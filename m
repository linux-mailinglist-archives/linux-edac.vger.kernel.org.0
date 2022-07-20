Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9ED57BAA5
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiGTPln (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiGTPll (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 11:41:41 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97112165AD;
        Wed, 20 Jul 2022 08:41:40 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KF4OXo008063;
        Wed, 20 Jul 2022 15:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=VcCBoLvlXzRMllZBW5nO3joVac7sRSk6OKXFlpYBpaQ=;
 b=IEBkH9uv2g6tDgqBIezJ7Ow8v9+XdTVsSVeKB+X7CvpwQeO21vxlCb9aKcvXsBijK0Yy
 axCdCLzQP60CyTtfd+87Rkdh52+gIXFx1+iMHWLMeA5d75CEtyvNjs6wtvRBdkUw32eE
 qYzoOfLBDJhbKEznskstsPcOWl4aVva0oLE6Pwn1D7FbiRi92Zy9sSicdk1uU28lnMVZ
 0TEH9D3GMtiObpLrh9dX0Q1B0L73KrEn2PBcJ7mSpCutsCIPFXWmOJWGJsw12ROCzWvG
 TtCca7vs1f+/1ok1QCL6iJ86E6UxOV7E9vmAjleGZsVCM4ya1YYujmI82iJ613HM8BnD Pg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hem188c44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 15:41:23 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 99A6E800196;
        Wed, 20 Jul 2022 15:41:22 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Jul 2022 03:41:22 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Jul 2022 03:41:22 -1200
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Jul 2022 15:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZmrPugO+UC9bbo5UqYhEeyN+vYTXkJ+csoeXvc4Ov0qK2juIoVEqSsdm5PkaUdO0TZGswrueqtrtR/iH+DUoR2oIbyYYof9ebeO4xiB5zQptsLNDAjDeN9XqlCZT1+HrDENv4B7nclHwaTkmGP7WurrGEUcMt2MEXNp0OpScXR6H04FHTp2MuKqThUEYjm5Hn+tAxE1++J39UVTuT9rocgYASMqkipVBknt9r0arfIxbA8NxVXIFUxdbDwub/2QOFPvPuWlp+H5tsm4wNj9i4nvG6/2M9iEBmPWXKYuNbip5TibWbwFgRWckU+eis7MAbDmrKykLsMvYKjB+iPUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcCBoLvlXzRMllZBW5nO3joVac7sRSk6OKXFlpYBpaQ=;
 b=jeA/GvO6kC6BQvGwjl0gTQL7H2i12gpu1VfhLZt7dzFAA50dkZMXHWic/+CcFyPLjnpmN7ZPuK+9gPFsLsNBqYtvI5voo49T9y6a7xFKfqpsbRjc/lFkRVdbRVfqKsbAWxX2Vhb/zn0wGWabRbaJ75KEJL4QOUsqmOGrUXVqE18SIm++dxyd1JZqaC3qhhjZERXOwk7WeC2jW4H+MfvXzE6by15hCtEgqgSF/hAnGUiad05q3qOOvTzhp4YHAXfsPFNvpGqCHP312txSiczp1nqHY7I4lXRNDYoNhlKe7/rJxC6PhaLcCpzdxmEV/ZnKlcZ4DXVTiTUAr1r2O8WgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by PH7PR84MB1886.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:155::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 15:41:21 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c165:fcd6:a6e7:3f06]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c165:fcd6:a6e7:3f06%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 15:41:21 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "rrichter@marvell.com" <rrichter@marvell.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>
Subject: RE: [PATCH] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Thread-Topic: [PATCH] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Thread-Index: AQHYm7smwrVZqUGvIkiseTl/uQAs+q2HJpiAgAA/+tA=
Date:   Wed, 20 Jul 2022 15:41:20 +0000
Message-ID: <PH7PR84MB1838CC03943D28806F7DCD8F828E9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220719220124.760359-1-toshi.kani@hpe.com>
 <YtfsOcWbWREu1NnK@zn.tnic>
In-Reply-To: <YtfsOcWbWREu1NnK@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59d82c21-3865-4dd8-6009-08da6a664b57
x-ms-traffictypediagnostic: PH7PR84MB1886:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9ssgy4j4+CEKyV0wXSJAsrYJzzgeyYnWml2eer8SVU7JZaXifiHCkZuXNc9l1PQkSPRVsH4VIA9PtB56XN/JHWR3v6HWpjVFcfcCWDy7N0Kxv2dH3T/1rUt7B1+wXNpAxPzMrb0geEpj9eHnqVvxYgOwgCot4HW5b9ke9T8HAOSuGoUEmMzQ/ykBxFsx9Bma27TWnTh8flJk7HevmMj2Z1sbDvSfyPSWctYj6r4hu+qsZMfvVM5Uu83dYU9Beita3NUie7adugc07P/SeAdrp/VLs8gs6jthdVZEjMzy3WGFZwDJef15i0rn7ahpTsaNmiaX7lXLvlK30rA/K+B6uZH8n0SP2cnSwqEZOXvMLvZCYxt3ArPYYtHYL+D7B+1xrBVv45Dtia/KGZI+M2BTpQScCCXL5Vab+cFI+1OBiAxoEsqrlDCA498GoX3HorP9YwQymz0ZLV4LB6UC9RAi20/OYhi4zBZGkwhcd+CxMe5kwmUGNsHz36TmPUCLi6FPNvieVQBaadGPgs6VNcPcMErDaMJlhJ8b4rXVxSoqbx1KyWAWCDVHsCuemr8mMjI3v1wjKR89N3d2VqJE/7DCLBHKFQDZM/yzbuw/mWD64lLnp45+09r7nRJL4A0um9M07MKaSHFtqTS0vs9mfCzVRb8JsQ49puw58ZihBL3UTtQxcn2XigmBZQrCmkcB1cWF9RacDYA44DM4KBnx8UGLDNsS5gOtKVlBw+YvKx1YxPSuq4ZAUE9AXxsmEQTy0DaiAHhCiJcWb9i6KvlkSHEeTWzT6PTaOC9dDBI4JF0515iTT8auwS4W5H4pnidRtemrE4tcLxYqKz2g3lqrPOk0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(39860400002)(346002)(366004)(82960400001)(6916009)(38070700005)(316002)(122000001)(6506007)(7696005)(83380400001)(54906003)(4326008)(71200400001)(66476007)(66946007)(76116006)(66556008)(66446008)(38100700002)(8676002)(64756008)(5660300002)(55016003)(8936002)(26005)(9686003)(52536014)(478600001)(41300700001)(33656002)(186003)(2906002)(86362001)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEZWUVUxdEtkVkVOcmxVV1pzdTJlYmtCSjZzbTVNK3JORG92MlJYWWY5MTdW?=
 =?utf-8?B?ZDJTM0huV01NbUMxbEpBME9SNm12NHpJbVprcCtFVjNVNkRkWkpDQksvTit1?=
 =?utf-8?B?TFlCTk9lZFJJL3FTS3RGV2FwVytGa2hrQitBdWFDR21FbXAzVWQ4a2E5bm43?=
 =?utf-8?B?RUl6MVp5cTlSK0N1bWdnTW1SRC9EUHViSzNpaGphalpRS040YTV4UGdabmJP?=
 =?utf-8?B?SFdwZ0lsbXd4bkFkV1E3V2VobklvaHVaU3hJenBpaW1wd2RaSWZaR0QzWUY2?=
 =?utf-8?B?MlQzdkQyTjJpUzNKWVNwVUVndjA3YmN3SlZvUlV4em1ZZUVyaG93QkliemNq?=
 =?utf-8?B?ZTR1Y1hwcHJnNk1tQW4vc2dZUFRGZzE0SnRLMVZZWDUzTlRKWElGOU9KK09L?=
 =?utf-8?B?VlBIbWFIRm5XWENaSi9MRzFxZVpQUWpNRU9WWU5jTVYxdExXSHNFWHFId0JY?=
 =?utf-8?B?TndwelA4OHZxc0NvdVdBZ0k5U3k0U05tSUVZbDFGY1VVaTNRVFp6a21sOFNP?=
 =?utf-8?B?dEJOWlhrOWpMb0YvUUFJbVJGWEdWQjBrNkZYOFM1cVBGd3h0VS9odlMvRUw0?=
 =?utf-8?B?SSt0ZmZoM0FZMjV3T0FSMS9GZ1pIUUtkeTYzeUJVUk42TTJHcnFDNnl2ZDlS?=
 =?utf-8?B?bVJaY3ZROERBRmdyWXlUL25HWnN6VG5RVy9RcGtRMXF3cnpMcjQ0Q3BhSFN2?=
 =?utf-8?B?UmhpOUpCbTFzekNGK2NFbWxab2NnQUJvZkNsd3MrQXFBZjZ3U244NUNvKzBa?=
 =?utf-8?B?cFhveldLYkV3V3hkL2VidHBEQVYvbG02QUpISVZQYTIrNVliZUI5YkpNdFpv?=
 =?utf-8?B?YzIvRW9ZOWxCQ3dsY0I0Q25yYXE0OGpmKzlWSlB4RTQyODBtbk9GMDZrZk9F?=
 =?utf-8?B?K1J5UWdKUXZlemx3MHhXMXE1WUg3V3ljaE0xNmhhUXkyVTVGRmdDWXF5TVpr?=
 =?utf-8?B?YUV1VXJNTVBsYUZKVTJIRFRsRzh5b2R6dGdDSEJuZ253cHFJK3RicFBpTnN2?=
 =?utf-8?B?bDhYNGxLOG5EWC9nVDA0ZWsyNllScVlhcHFMQTM1VTBWZ1VINGZXSVBWcXRp?=
 =?utf-8?B?YXZOUmhDYVYwbHhsQzV0QXBjTGVUOEV3RGZnTXhjT0svUDlYUzBrT0JTNWJy?=
 =?utf-8?B?NHp5Qk45cGkrTFR0OEQvY0lxMU5kQklPMFFZdVozaEkvRnVLWEpWRXZKd24z?=
 =?utf-8?B?NG9BTVNrL3F2V3V0WTNRQ3l6RFVwT1BEUklhbFhDSHFlMFVsZ3dzZzl4RW14?=
 =?utf-8?B?VlFTVEUxWTFIM0doN0oyaGtkaFZsNUYwL2Q1L0VBakdtcFlodG0rS3d0YzNa?=
 =?utf-8?B?TVc3djZ3anEzaDR5ckhTOTRyYnZmUzdMQkMzMzI5QTVLRFRaWmRaeEN0NEx5?=
 =?utf-8?B?WWJrVFR5UFlWcHZKYjhGNG9oUWgvYXRURmtmbjhBeE9aZi9OLzVYWlg0K2VV?=
 =?utf-8?B?a2hYVlNuSDE5RDQwRmJDeTZOTG52cjZUVExaZEN1SS9Wd0ZZQy9JYUNOUW5q?=
 =?utf-8?B?QnR1aVk3Sjc3Y1UrK25xY0s4emxDN1ZrRWJSTmowbDdCalg5VUtuQlluNFNT?=
 =?utf-8?B?K2xyL2kvSDdmSWN0K3dIa2pyNGg0dzd6UHVhenBkL1l4bjd4THA0eFp2dW5J?=
 =?utf-8?B?MUhyNVA2T2ZlbittRisydmlZejc3cTdsRHo3Z2lkMGxRd2pBK0s3VVQ4SnRZ?=
 =?utf-8?B?ZjVibU1aTlhuV1dDWWh5WHlNQytBWi92UkZPYWRQM3R6ZEhGK2hNOHYvSEpo?=
 =?utf-8?B?ckFuVlM2M3VTNzdHTThzVlpacTN1cUoxYkhVdkZuMzBoQkRKTmxaNHF4TjVO?=
 =?utf-8?B?Q0NSMmx2ZUw4WCtIUWJMakJHdHA5dkZ6bWg3bG1VYkxZWGJSdXNqb2xKM2hr?=
 =?utf-8?B?dGRSYkt5VlVwWVMxRjM5eG1NNllldlQzRGpHNDZEclFGYi92VkFlUlRQQVl3?=
 =?utf-8?B?N3lianBzNXFLVThUZ0hRaTRYUmRhNTlqRC82LzgzZGMxQXJWeUpDRWZ3OCtk?=
 =?utf-8?B?Wno2ZlA1N1RVOHEvL21Ia05jRHN2SEl6a0lmeDdTNGg5VVpnOVlDU3Q4U3NL?=
 =?utf-8?B?K1c0M3VVdzZwY0x4UHZEZmxXbmRQZXVOajdpL2Qzdkw2dXJibGl0LzlhcFIz?=
 =?utf-8?Q?xKJhZ+8KBWrm/LH5sbxBeEqat?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d82c21-3865-4dd8-6009-08da6a664b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 15:41:20.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATAekl8Xwk9u62b7Y/3wC4/p5qYN3JBFA9hY2YRRXM7cRbIUxVYN8TE7eqO9kbJPregWGMBemAfw3o2acimrow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1886
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: OhrxsrLIPWATsfw8EFPUeZP-CoSVYH2j
X-Proofpoint-GUID: OhrxsrLIPWATsfw8EFPUeZP-CoSVYH2j
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_09,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=555 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200064
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Qm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUdWUsIEp1bCAxOSwgMjAyMiBhdCAwNDowMToy
NFBNIC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+IFRoZSBmb2xsb3dpbmcgYnVmZmVyIG92
ZXJmbG93IEJVRyB3YXMgb2JzZXJ2ZWQgb24gYW4gSFBFIHN5c3RlbS4NCj4gPiBnaGVzX2VkYWNf
cmVnaXN0ZXIoKSBjYWxsZWQgc3RybGVuKCkgb24gYW4gdW5pbml0aWFsaXplZCBsYWJlbCwgd2hp
Y2ggDQo+ID4gaGFkIG5vbi16ZXJvIHZhbHVlcyBmcm9tIGtyZWFsbG9jX2FycmF5KCkuDQo+ID4g
Q2hhbmdlIGRpbW1fc2V0dXBfbGFiZWwoKSB0byBhbHdheXMgaW5pdGlhbGl6ZSB0aGUgbGFiZWwu
DQo+DQo+IERvIHdlIGFsc28ga25vdyB3aHkgZG1pX21lbWRldl9uYW1lKCkgZG9lc24ndCBnaXZl
IGJhbmsgYW5kL29yIGRldmljZT8NCg0KWWVzLg0KDQo+IFNNQklPUyBoYW5kbGUgd3Jvbmc/DQoN
ClNNQklPUyBoYW5kbGUgaXMgY29ycmVjdC4NCg0KSW4gZGltbV9zZXR1cF9sYWJlbCgpLCAqZGV2
aWNlIGlzIHNldCBidXQgKmJhbmsgaXMgbnVsbCAoZG1pX2VtcHR5X3N0cmluZykuDQoqYmFuayBp
cyBzZXQgZnJvbSBTTUJJT1MgdHlwZSAxNyBCYW5rIExvY2F0b3IsIG9mZnNldCAxMWguICBUaGlz
IHZhbHVlIGlzDQpzZXQgdG8gMHgwIChudWxsIHN0cmluZykgb24gdGhpcyBzeXN0ZW0sIGFzIHNo
b3duIGJlbG93Lg0KDQpIYW5kbGUgMHgwMDIwLCBETUkgdHlwZSAxNywgODQgYnl0ZXMNCk1lbW9y
eSBEZXZpY2UNCiAgICAgICAgQXJyYXkgSGFuZGxlOiAweDAwMTMNCiAgICAgICAgRXJyb3IgSW5m
b3JtYXRpb24gSGFuZGxlOiBOb3QgUHJvdmlkZWQNCiAgICAgICAgVG90YWwgV2lkdGg6IDcyIGJp
dHMNCiAgICAgICAgRGF0YSBXaWR0aDogNjQgYml0cw0KICAgICAgICBTaXplOiAzMiBHQg0KICAg
ICAgICBGb3JtIEZhY3RvcjogRElNTQ0KICAgICAgICBTZXQ6IE5vbmUNCiAgICAgICAgTG9jYXRv
cjogUFJPQyAxIERJTU0gMSAgICAgICAgPD09PT09IGRldmljZQ0KICAgICAgICBCYW5rIExvY2F0
b3I6IE5vdCBTcGVjaWZpZWQgICA8PT09PT0gYmFuaw0KICAgICAgICAuLi4uDQoNCkhhbmRsZSAw
eDAwMjAsIERNSSB0eXBlIDE3LCA4NCBieXRlcw0KICAgICAgICBIZWFkZXIgYW5kIERhdGE6DQog
ICAgICAgICAgICAgICAgMTEgNTQgMjAgMDAgMTMgMDAgRkUgRkYgNDggMDAgNDAgMDAgRkYgN0Yg
MDkgMDANCiAgICAgICAgICAgICAgICAwMSAwMCAxQSA4MCAyMCA3NSAwQiAwMiAwMCAwMCAwMyAw
MiAwMCA4MCAwMCAwMA0KICAgICAgICAgICAgICAgICAgIF5eDQogICAgICAgICAgICAgICAgNzUg
MEIgQjAgMDQgQjAgMDQgQjAgMDQgMDMgMDggMDAgMDAgODkgODMgMDAgMDANCiAgICAgICAgICAg
ICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KICAg
ICAgICAgICAgICAgIDA4IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwDQogICAgICAgICAgICAgICAgMDAgMDAgMDAgMDANCiAgICAgICAgU3RyaW5nczoNCiAgICAg
ICAgICAgICAgICA1MCA1MiA0RiA0MyAyMCAzMSAyMCA0NCA0OSA0RCA0RCAyMCAzMSAwMA0KICAg
ICAgICAgICAgICAgIFBST0MgMSBESU1NIDENCiAgICAgICAgICAgICAgICA1NSA0RSA0QiA0RSA0
RiA1NyA0RSAwMA0KICAgICAgICAgICAgICAgIFVOS05PV04NCiAgICAgICAgICAgICAgICA0RSA0
RiA1NCAyMCA0MSA1NiA0MSA0OSA0QyA0MSA0MiA0QyA0NSAwMA0KICAgICAgICAgICAgICAgIE5P
VCBBVkFJTEFCTEUNCg0KVGhhbmtzLA0KVG9zaGkNCg==
