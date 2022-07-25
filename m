Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C5580304
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jul 2022 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiGYQmG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jul 2022 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiGYQmB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jul 2022 12:42:01 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205DDDE;
        Mon, 25 Jul 2022 09:41:58 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PCXLJI022689;
        Mon, 25 Jul 2022 16:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=bV/EKvhs9OwSHOUqa68gb0jxgkyZFO6E4OMEO2GaFOA=;
 b=asXZSXtt6TOeptJO482MC04hkuplVOYmyD9jFzkmoQCRDaVJo5T0/5Qqll9zKd5FcPUC
 zXooNPuuglHCIBJhVQq7i5UjcKixMZyTCpferWMltKQRILBRrM0BHNXrgkECyOWVgXkS
 51zpkAt3AtUFhXUF8PnTYQEO7c570nwjCxVclvxcU6V5k6oOIe4UPW+LzlZcktFivLHJ
 hypQyj/kHjD4kytCSCwZJtleFkO/11NqTMzjUnNuibGlAr6avoDI2uJewoNDgZ1zWCn8
 JCX6HfE6pfJM1J0wLoIRBEmFQ8V5TxcuCgbsCqTFU2ekp8XBDBg/5zG66pDokQdfuMFB Jg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hhra43wem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 16:41:42 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0CF4CD2D2;
        Mon, 25 Jul 2022 16:41:42 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 25 Jul 2022 04:41:41 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 25 Jul 2022 04:41:41 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 25 Jul 2022 04:41:40 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZKk3ANEyB+M8KgFfKU/J14vsGgaWKCYP1jNlp3qCpJGrjp0dJ61rOUEdNqjTe2+H8Pkp6QcllMJGQshT4jhELm5LGAFTWqPWCIezBF7ir08DAUlmqeAW2zh9v87fIEEGKIxKHEodvBWQWjm6l8eIFu3+z8gukcJea+6cXlYagZknrIS+n5JFnO5AoO2UNq0tvQbOQ211ip+uepTlcZkwi4L9rLi5HnNakLmYOZ5snEMylFysevk59Yk33chEhTkMQVcB+NzDhhBK6QY8iW9d99Q//Se0rF8g0peX/U3rafpfafyQGIMZ754pj69oowhecKC6OVgBjUluX9hbRd7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV/EKvhs9OwSHOUqa68gb0jxgkyZFO6E4OMEO2GaFOA=;
 b=Cpxt52okdThpTtCaFltOZ3Uo/oFi9DUiAFmFgiUG15CE2N10DtX+yPh9+SGqaHHWwgF8MRAHux/9pvOaRj4NKKrR5tcBnoA0AaJA1FSx0vCnIqgcHefg/6vJLkhNHC1IDPz196Wy8dqOZs6B7EMYfGT6J4/96Cj3S1ysgbutK5y57CQZDS2b5o3VDLkonGRhElS6MrQqnWy5RJcpxwsNz9GVIAUKi5+GB46zYI/cOZpdQ/bJsowCco4RP6rU9Db2H0//H21bF3DrjtrEI7obxc8WkhkA4E1vlmRmmoGkofGpkHeSlcyYQiwcsUw6p7thFeTfw5b1xwyNBeiXIu7kuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by IA1PR84MB3059.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 16:41:39 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7920:7065:a013:4bff]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7920:7065:a013:4bff%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 16:41:39 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Robert Richter <rric@kernel.org>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Thread-Topic: [PATCH v2] EDAC/ghes: Fix buffer overflow in
 ghes_edac_register()
Thread-Index: AQHYnSx3rMQsGJx7KUaiCXMepzwFya2KYV8AgAR89QCAAAXwgIAACKUAgAAGrYCAAAP7AIAAWEbw
Date:   Mon, 25 Jul 2022 16:41:39 +0000
Message-ID: <PH7PR84MB18387C764ADA73AEF00E5B1A82959@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic> <Yt5oAjbZ5Koy9v5i@rric.localdomain>
 <Yt5s/f/jyRcFY1Md@zn.tnic> <Yt50Pp3kQRCtSqw6@rric.localdomain>
 <Yt5510+uLKzv+Qvt@rric.localdomain> <Yt59LiHs3gWNpNW1@zn.tnic>
In-Reply-To: <Yt59LiHs3gWNpNW1@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a86af98-9f56-49c5-571f-08da6e5c8c38
x-ms-traffictypediagnostic: IA1PR84MB3059:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IW6vCFJH6rtNCWHkATcETFqbJybXjVNfvjgTLKGMJEn8IHnySQ4F6XtbLkGCws7mfpxYnctKHUcCen/ScA8/RN7sUWOLBOv+fsX4x5ZT1oZUoN5qlJiwB9YO85NFxKH424nZZtr7aP5hlTev2KVbfauxVqyd2rb2yjvDQSVs2WKnO8UlW5sYxFHQcVEtGLnRtXCNRSUasmKLbD+VynJ3b6Bt0otiJuts8CoU+aaAUOMZLXqgCx2JGRFEPZrO7ZpIoW/do726kpwo+1atct5Xzi5r/kMRjbB8MKixyJR7clVNjbiiSkjmhaCVC5CsBrrdc9MA/PJqEuYmi/Q7ulY3migCZpE8iKYLzSEIChcY1/Bpl6pCTr+P4InwrwskWqjNhWMKmlU6LAoiCDGVgmbMSyMSKticEDm4T5xfQq1eVHzEPgUOPBG8pSORAOJ33zxeWzARUwHUvdTgzChDoRTNWnzQAWvlhAp5fjHIplWuIlc1pqjBnpWBhxVy6qKsksnZSqVwjaIEL14+TwtZQVAIoxSezELUjSn4uqcTZIXBMfRbztk9Qb5OEEVwzNt3JaQBan1ELb876ahM70V7Sbm5H+Tyx+7dwLc2fLh7MPSJVqzvnFlXriaDRBthFHOuQW/Ru0y/3s1P7K17gZwo+51iJVhzQSQ9L7ViSYhK7k1Ixq6B9gq5dq7vVGjqJMHtkBJCBOrvm48UZH4dakVxs2NOhWeLEWpNwQCWATU4joZN7IKxxg+AK7oNpkueoW1DN/v3wL0VUDFeolvxvPgNpc+IN/uP5/Ukqb7Bz1fU1/hgUCs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(39860400002)(366004)(136003)(4744005)(26005)(8936002)(5660300002)(478600001)(66476007)(33656002)(52536014)(66556008)(64756008)(66446008)(76116006)(66946007)(86362001)(9686003)(4326008)(6506007)(41300700001)(8676002)(83380400001)(7696005)(71200400001)(110136005)(54906003)(316002)(82960400001)(38100700002)(122000001)(55016003)(2906002)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEhCQkpvSmJpSXB4dUlpRGlDTGM2ckNEdzV5OEVtOGNQaDhBamFVSXR3bjhW?=
 =?utf-8?B?M3BCNG5uaXk3VW5jSXROalA4NUdCbVRad0pFdng3RmVYQjlSVHZPTG8xc3VR?=
 =?utf-8?B?SlEzemdvMHpyVHBiekszR0N4SWV2dmF3K3JtMUlpYnkxYkRBWktjQzRJek1I?=
 =?utf-8?B?V1YwV2djbEE5dWYrV2d6YlZLVTkzRm1xbUJZN0ZZQXFubkNYZHRnWkhrYTRq?=
 =?utf-8?B?ZlN2TG9xNVNuQllvYUJTWTlpRWlFMXhQTlExcHdGd29LWDc2SVVDYnpiVXlm?=
 =?utf-8?B?QllYNmdWTVpzV0RlZVY3UCtuRHNMeUxCdEh1eDRJeDVCcFBiZkY4NmhJdTJR?=
 =?utf-8?B?NkxESGFabnR2OVh1RlB1MnBXd0R3K2N0VmpLWDhQVnI1NlEzWEt3ejBVUk00?=
 =?utf-8?B?emhaZ3E5L0FJR2w4RnRHWFlxOFFRSVgwQ29kaE5tc280RExVTXo3U2RJTjV4?=
 =?utf-8?B?U2N6Wk1QUHRnQm40NU1oVWZmYTdZOHpNUk0wbnBQTDZkS25BZG5oV0hRNVFx?=
 =?utf-8?B?NnpzaW1rWUpUVi9qMzVDM1hseko1U1g5SW1zbmtYQUlEN2wybnZGUDhjeU4r?=
 =?utf-8?B?cHh1c0lGTDQ0cHM4TnJxanZGS3NNWG9Zbm1UZXUvdXQwVVBZU0pITVNNQzMz?=
 =?utf-8?B?Um16bFlrNjhZN3lHTVh5WnJGVzV0Mlk4N2VLdU80WUNNdkF5VlNXanhpMUFk?=
 =?utf-8?B?d3QwQVZibkMyUytMLzZDK0pzZnVqRWM2cUE1MzNMNzI3dDZYNnNzUFA4WTdD?=
 =?utf-8?B?azQ3SkphSCs5OW1CVmcrYkQva0UreW0rbzdnWVJTYUFHb0NQd0NON3RSbjN5?=
 =?utf-8?B?RUpEbnlkdGNaWmRuK3NNUXNTT1BIVEcvZzFIajVIMk9SNjgrb0R5R3IyeGtM?=
 =?utf-8?B?NklYcHNjQklZbmYzVU9PbFJaN2h5djVNSjQ4dFB3YUtacHdpOVNnQ0xySzRa?=
 =?utf-8?B?Z2ptdjFrRVlYRDgzT2RMMlJSeWxoWU8wQ0hXWjRRd1JaUkVoelhjNnd1OERL?=
 =?utf-8?B?NGQwdmpxT2FEU2RleEp4ZWh3Z2NpVjBGOEFnM01STlhaTENOcmJ0a2IxSy9L?=
 =?utf-8?B?VmFmNytCQ3FydFJLNDJwMm5hbS9seHlPT0RaRVI3OUI0N3d0ZUc1cnFLRE1N?=
 =?utf-8?B?dVpUUTNhN0llcUZsUmpPU041bENGenJVbEV0c2w0d29HengvM3NCMXhoUHJT?=
 =?utf-8?B?dnNjdFUzYS9OVzhISjBzMHcxZEhRRU55MjJVOXNJbFNIcHdPNVJPZkdzY3Ar?=
 =?utf-8?B?cDlUM1BxMUdYZ0FQTTNOT3VXL0cyb3F5Ynp5NHFFUmtNaUZucHdiakJXY0lK?=
 =?utf-8?B?Q2NKQTduclNhdlJDUWx0K2VBZlA5ekgvMElrK1FDQXN0Q0o1MXZtdzJIbys2?=
 =?utf-8?B?QlYwSUlCMWNqT1NMWWdjZVA5M2lNaUpXNEd6bDdROGpPd2x4dkJpK2NZMkdr?=
 =?utf-8?B?b21aWVB2eTkvSWQ4U0V6TzBsMXFBMHRSVElGbmtOZE9Ua2NKTEdpQlJMK3VZ?=
 =?utf-8?B?MG9leWN0RXNIZjBRc1JDOTFUVUc3Vjc1YjFWMzBId3RDSUZuVU5Wb0h0b3NX?=
 =?utf-8?B?OXpCV2R5MWRPdjFuTEQ1enkrcHk0TWZtSk9tZzdoNUpwOXhaeEh0TVBFTkhQ?=
 =?utf-8?B?WThIdTY1YnF5bEk0Y3MrOGkrMkdZeEpjeVdhZVg4Um1kUzBSbndQWEJpcUJo?=
 =?utf-8?B?UDBqTmJ4ZDZFV1ZsTy8zRi9UbHU2MVBnUnRnSzR5eXBSLzRWUUpHQk4vdGxl?=
 =?utf-8?B?aTdnR2JDWkpidXN5aEhUV1dVQmttNE1pT1ZPRUJkOHB6T3lqazYvcUxwYk5F?=
 =?utf-8?B?OVhqTnBaM2tCMWh5c2NyTWpySFlaRk9zTTlPbUxxbXk1SCtDaWlDeW9PZUNq?=
 =?utf-8?B?ZWErQ2ZOZWdRWGlSbnRzdE56MlNHNEZKeHpoNWdBamRTbWpCMDZNWVdRNjhP?=
 =?utf-8?B?ZnZaaXl4eEVwcyttMkZkZkdzc0RnaWdCWThWV3VyUUkzNy9XOFN1azhnb0dW?=
 =?utf-8?B?MWVaNS9HcmU4TWMxb3BoSHZtRS9BelFNV1krQlN5dHVKNWtRZGxBRVpYMTVx?=
 =?utf-8?B?QzYxTXFuYitYcTMrL3NzTU1GR09mcGxMT3gvVDZ0aXhyMlA5SzQ1Wkw4VUQ2?=
 =?utf-8?Q?vOzWNMQ1DiNyss1uzOfOP/46T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a86af98-9f56-49c5-571f-08da6e5c8c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 16:41:39.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bj135DTDag0tcPocvew5B16X3gc4QrQb6qpm/pgPZmCDuMZdl0Ba7n2nV3lWWAmM2Y1HrIbtGj+q2I9oxBniiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3059
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: ZGWttJEjD3TWAEE8KFxQ_KEIBcINEw-R
X-Proofpoint-GUID: ZGWttJEjD3TWAEE8KFxQ_KEIBcINEw-R
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=892 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250068
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Qm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDI1LCAyMDIyIGF0IDAxOjA5
OjExUE0gKzAyMDAsIFJvYmVydCBSaWNodGVyIHdyb3RlOg0KPiA+IEl0IGtlZXBzIHRoZSBkZWZh
dWx0IGFzc2lnbm1lbnQgZnJvbSBlZGFjX21jX2FsbG9jX2RpbW1zKCkgYnV0IGNoYW5nZXMNCj4g
PiB3ZSBsYWJlbCBpZiBvbmUgb2YgYmFuayBvciBkZXZpY2UgaXMgZ2l2ZW4uDQoNCkdvb2QgaWRl
YS4NCiANCj4gWWFwLCB0aGF0IHNob3VsZCB0YWtlIGNhcmUgb2YgYWxsIHBvc3NpYmxlICJjb25m
aWd1cmF0aW9ucyIgQklPUyB0aHJvd3MNCj4gYXQgdXMuDQo+DQo+IFRvc2hpLCBjb3VsZCB5b3Ug
cGxzIGFkZCB0aGlzIHRvIHRoZSBmaXggYW5kIHRlc3QgaXQgb24geW91ciBtYWNoaW5lIHRvDQo+
IG1ha2Ugc3VyZSBpdCBzdGlsbCB3b3JrcyBhcyBleHBlY3RlZD8NCg0KV2lsbCBkby4NCg0KVGhh
bmtzLA0KVG9zaGkNCg==
