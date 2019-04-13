from osgeo import ogr
import json

data = ogr.Open('ne_10m_roads_north_america.shp')  # 返回一个DataSource对象
layer = data.GetLayer(0)  # 获得第一层数据（多数Shapefile只有一层）

extent = layer.GetExtent()  # 当前图层的地理范围
print(f'the extent of the layer: {extent}')

srs = layer.GetSpatialRef()
print(f'the spatial reference system of the data: {srs.ExportToPrettyWkt()}')

schema = []  # 当前图层的属性字段
ldefn = layer.GetLayerDefn()
for n in range(ldefn.GetFieldCount()):
    fdefn = ldefn.GetFieldDefn(n)
    schema.append(fdefn.name)
print(f'the fields of this layer: {schema}')

features = []  # 图层中包含的所有feature要素
for i in range(layer.GetFeatureCount()):
    feature = layer.GetFeature(i)
    features.append(json.loads(feature.ExportToJson()))

print(f'the first feature represented with JSON: {features[0]}')
