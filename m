Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B158CF41
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 22:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiHHUkv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbiHHUks (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 16:40:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5AEB4;
        Mon,  8 Aug 2022 13:40:47 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278KTPu4005277;
        Mon, 8 Aug 2022 20:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Y9AWbKpJ1fCVX8ujXIi/3+3i03IrGBkztudYYd2f+xA=;
 b=APcOAZwQo9RjULZJjb+v2PqJ1InVvPdDcy7twHmMe+5sgp1FI4PE3rvDqdNWVqE+1AmZ
 VyhImzHbBqMOghHbXDsv/yfhAbH16to/UAMIFOT2QhHnxQt5p1OnQWsiv3GUkhhTzoPF
 nINpg30N6FoKi09jxhu/w5wTQKctY4Xsa4FO6WDP1cSZigci+Pd3tsliyNxNsQelYR1A
 ab+iY+ksX/CPJOIncdBNiotoRK6Ea7hhXfmKbeSqGiupE2zCiEO0pmXF6Vog7X1br5ox
 a0ZYzPxST4Y8Wk5lkjoU/9Pkc638DpGzfn9/2vmIrBnWsxsfAP4U79MiPsJ07/fjPNXH 9A== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hu9jq83ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 20:40:22 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 94440D2EA;
        Mon,  8 Aug 2022 20:40:21 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 08:40:21 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 08:40:20 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 8 Aug 2022 08:40:20 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 08:40:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZgNOyOipOrDK3cQ4SHfFX1hms74u0/JRtu4PbqhObNKoOrLdhvLDkXTS48s2tQuweUKq4yWhzrEYuvP1b0BcwQrJQgxG4GqhLgjB2pAjd8SLtqVYyV4Eil2mq9OjCN+9CfBN0MmPBga4tlq1N4tYQjq2EU5uk7mHIVZAqtuuIJtgeLMPrrP/YO/KJpKoR/7FTsEkbqFUrl4YbsGzeJYnq4RGhlVITU6JY2GGiAU+dq92+wfe2CGVF/S90399rmrx98Qo9mF9SwpaDp/3QHKLRGdRm89AGG9AovEGWoLuONpzkR9f6qynI6AYBJiZclbaKAqk8Y/uL5ko07UrIJ6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9AWbKpJ1fCVX8ujXIi/3+3i03IrGBkztudYYd2f+xA=;
 b=Kw8qyyOLzFY/hU2uE4QNYv2U9BAdYEcI7h3Qmets30zaZen/RvlCw/NNgkinJ4eQPjMsVzP4ri9vElHXfXGW2IRzAFoAYliD1gqShqI2rzcbsX4FDaiyhyERnuVekIgaKv8Ts81hSqOu9Ii3vqcyNXYbBDcaSmmFYxqARqDxTe3ixmg36zGrBcxJa2eG3bQTJwJ9GLGWMLurCHQ9IsG6TYwhG30Sgc+Mjnen8BybRUJ349MpLTKPN2L5WV4OEALD5DM3KGByTUgsXDQp6z20C8DHBWpyevqZIAIn5pvUx9sXn4e3cOOwNbwHElaNgdstLBsEjiCiWFaEF6HuBFiCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by SN7PR84MB3255.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 20:40:18 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 20:40:18 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Thread-Topic: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Thread-Index: AQHYq1YbHdpOiV0alEuUJHkPzB7Jbq2lceiA
Date:   Mon, 8 Aug 2022 20:40:18 +0000
Message-ID: <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
In-Reply-To: <YvFX9vTilqMpsF9u@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ccc5e1a-10a3-499b-c069-08da797e34ce
x-ms-traffictypediagnostic: SN7PR84MB3255:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQDj89LcIEoT4kFZZQC9Up5UsIfytsvxdqYzQzbis/TEad6MOerGScL+nLC1t1j0W24rgLfpDft6CbaWdffaZTY8otAJ+kBkOAVdbIeQ2ktT/SFBGaQk1S4dyYazbUZkdEQ6UhAtrbZZrjfMK/2CY5ZRBAUiKW33iABgoPeM/iQoDCHZJrJ1T7YOgVb6Xu+3ypcDQrKg7/0gCwrCGjqvqsPfuh6iYljuFdZpUDZayoUF+JJBgTzfwDdbkCgDuA0iAtLRDN8eeO6TY7/lcjG8//wl9+eG1DYGJSXYF58Fqn7PziZUvdTf3IezHtlkFA6ILkKxGFSlyGj6+1YL7oRcX5TN4UFyjfmfN0n0nkTncnT1QJdCyO8enzeb7PTFtP4Q8KBw4RspgabYbs2r/ng0lDbOiCueIbcl4OivmJYug9fozBE9iBatq1lN3CAjvu5ddx3gqYph1dr+MCAUiTDH8L0jmVY+cclWGmj+OGmYJ2b6dDHTajeMQlgnsDpJF86f3FcL0KKct+aF/c2vXnDpHkf3EMUWj3P8NNwOKUOjGbt85M/kEJv1Ljq5zuWQle5P1G1/fLzrf3jdx3s8IsmMophQfGWDXSl7Q5EpfoidVlwf3KY/lZqErhXGlVnt0d1vPlOriUn5QUO/5eWlw/f/wEWpt7tDDWkNUgiuJeAyUIX8ABL+gQGQq58J5mO8IvI1WNwyV1qteS1lTk6OB09ilFHYOhOYdFD7A8dmLkzmIiqoKgLZ6prsZb4iKWpCTm1rRdgXI2eYPj/Qz8YpLDPpHlCADn1QlrLNKXr6L2miyRTp29sOaFNPOaK+CaQl0Bn9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(39860400002)(136003)(396003)(4326008)(54906003)(8936002)(7416002)(76116006)(66446008)(122000001)(8676002)(66946007)(186003)(66556008)(5660300002)(66476007)(64756008)(38100700002)(316002)(110136005)(52536014)(71200400001)(478600001)(2906002)(41300700001)(9686003)(26005)(33656002)(6506007)(53546011)(7696005)(55016003)(83380400001)(82960400001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVJJSnl5bmpmZmV3cG02Tk5aRFEzT3FUdUtoaUtyN2hKTVU3cGRoRGF6ZG5i?=
 =?utf-8?B?WmxObmk5WHF4UDhiNURXOW96M2JRelV0ZGd5N3BBOWZ1VmkrUmtESjdmT1Vq?=
 =?utf-8?B?a25CMmRCZnBWM3RjSUZPall6ZWFuaERaa2dhSlV1cTk0cHkxUWI2d0t3QmNi?=
 =?utf-8?B?T1BvT2U2amZzMVRMWU1MV0lJM0JMemFPT0QzWjdDQ2w4TVpHRE4wd3BpVDho?=
 =?utf-8?B?L1Q0KytyS1VHTFN5L1FWT1FvRkE1RUpFM2ZiaERad1QvRkJ6VmNYZlppcnFt?=
 =?utf-8?B?NlJBWHRhd3o5aFpQaDNOOEpjMWdEOE0zZmdYMW0rZ0MxQVlrcVVuQW1KZDlW?=
 =?utf-8?B?YTR0Sjg5bGFYUzVRbjI3cE5QVmVOWU5sd2tMdUxmRDlURUEzNXltam04UndN?=
 =?utf-8?B?N05zeGRxc1YvZnZPSm41UTArRG9wQ2lCQndFU2ZxK1ZlRTR1bVUrWThQelda?=
 =?utf-8?B?a0ViYk55bWExMm85SHRWYmowQ1dsOTJPWWV3ZExhM0pyV2FJUzFIT3RSQlBn?=
 =?utf-8?B?WEhPTnpTNTBvM0UzdERjMnZ6dUFUd3FtUXM4MjI4Q1RmR21KWlk2WVVwZVFw?=
 =?utf-8?B?VjdwSXk0N3VUMHVYcmZJU3dFeXRhTXlMRDNncGZORmw3Q3o5MkJPS3ZEbTJl?=
 =?utf-8?B?dmtFRDNBdWhNLzByZlRyTFBKQlBTOWNvQ1MvVEFvUTdyQ2dFL0RRZ1poQm92?=
 =?utf-8?B?bWVwVElVZjhoL3FBNlhBS04wNkI5S3hMVWYyamZsb2pIWEdoMFlHd2IxK0c4?=
 =?utf-8?B?Tnl6ZlRnWFJaWHY2SVNmOUVLZG53eklEZG5FOW14SHFzYkZkTHJJS09pU1do?=
 =?utf-8?B?bHp1OXBNUkM3UEMrOUN2MGJxempQbllDejZVaXlmak0vTEMzV2wrRGYzWUcr?=
 =?utf-8?B?NW1DRmUxb0NkeS9QRWJkRTQvZXYvcXMvQVd5ekoyOVdjb1o5VVo4M21PdURW?=
 =?utf-8?B?WjdTdEFXWDZQRVNQUW8zNHUvMGFIdGpJTzBPQ3FQTENVNzAwc08wZjdTaE45?=
 =?utf-8?B?MFpkbkRHMnJoSENJMnE2WnY0TnZjbUgvMEE3MjMyU0JaUFh0cnV3S1h5YUhF?=
 =?utf-8?B?RTRqQngvUlpHMlZELzQ3dXZtbXNOVmc5SzNmM3U0aFVTd2t5aCtTKzY0NDVa?=
 =?utf-8?B?bzRoT05MRWNsbzVoMFhMUXhCWVUwSkpyR0hXY0dmR1VNVlREdy9TTktIU0NI?=
 =?utf-8?B?blh6eVRKZGxlLzlramtXeGZUWXd2TkIzOTBka2lKN3VKbzE5V0tXblB2a05s?=
 =?utf-8?B?OHZ5eWhmdUZ1YmZIL0E1Nmw5enhuaGw3LzdWWHZ1RWwwcjZvWE9CRnhsUHBL?=
 =?utf-8?B?OVBlbDM3YTFJTS9VZWtpRWdaZVh6OUlhcjVYeEdDYkJ2K2o1aVN2aXdjTzdE?=
 =?utf-8?B?NHQzL2VVa24wUitHRXJUeWQvTDcwZVhwYS8vZEhwZGhHNXhSUkVZTzkrVVh0?=
 =?utf-8?B?U25Kb1BDeFhQT2dFVGZTTDRPdCs2bGtSK1BMT3JqREs2MTFIZXc3V0d3ckpk?=
 =?utf-8?B?YXlNR1BPeU83VE9PangrRHMydVNtbmgydW9Wa2VSWmZ4OERDVmc0MjF3ZThX?=
 =?utf-8?B?UkFCQUJFZ1ZqamFTQ2hJeFN2bGRhNTExelVwNUZhTHdybStURjAzQnRJeGJN?=
 =?utf-8?B?bWltcHZaaGlnd0VWNHU3d3REdHdpalRiZHh5dFZlQUJvYlczUEVvbGVTTjFa?=
 =?utf-8?B?ZThtQ0dkKzR4RmpLRC9zclFQckhSb21WbnQrVEJIYlRucTVoUGtOKzJvS3BF?=
 =?utf-8?B?KzJQSnB1UXBvZ3lwU2IwSGdhZ3BHUW4xL05VV243TWhOVWhqWUFaMnY1a09j?=
 =?utf-8?B?bkNmR3hyWlVIb2ZJUTROaTlXWWJxSWRNUEZvWmJSNngrVWd1eExZeGJKaXVy?=
 =?utf-8?B?dXBRME9oZlF6N3ZLNmw4MVhNUG02OUYwZ0ZoNDFUWEZ4WWxLd2JVQ1oxVXpU?=
 =?utf-8?B?aDluZURSOXM5ZmNIak1nZ2puaWY5SGpVbUMrWHpDbmY2UzNDR2RFRzhXRktj?=
 =?utf-8?B?L2o0dDBZNFhEZkw3Tm42T29TSXYwdEZFTzl0ZDkrRGIzemZOVGQxRnZhb0pE?=
 =?utf-8?B?RE9vdjIrc2krbldzTjVqam1YS2cwa0FhS2ZESmppdDlsZHNSM1Z2U0JheGFw?=
 =?utf-8?Q?RqVUsysgQxpAanZA7xRABlm/+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc5e1a-10a3-499b-c069-08da797e34ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 20:40:18.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHsBSOMRzHAZwc543REz5Otc5CroPCGBFBxtUqaBSVl8pKS2GVo4AtpcyPNU9han2uERbbvpaQbvBRGubNyJuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR84MB3255
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Pvf0N0B75tZJCNjhCojp5UiI8L10_C2I
X-Proofpoint-GUID: Pvf0N0B75tZJCNjhCojp5UiI8L10_C2I
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=638
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgOCwgMjAyMiAxMjozOCBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPiBPbiBNb24sIEF1ZyAwOCwgMjAyMiBhdCAwODoxNzo1OFBNICswMjAwLCBSYWZhZWwgSi4g
V3lzb2NraSB3cm90ZToNCj4gPiBUaGlzIGVmZmVjdGl2ZWx5IG1ha2VzIEVEQUMgZGVwZW5kIG9u
IEdIRVMgd2hpY2ggbWF5IG5vdCBiZSBhbHdheXMNCj4gPiB2YWxpZCBBRkFJQ1MuDQo+IA0KPiBZ
ZXMsIGFuZCB0aGlzIGhhcyBiZWVuIGdldHRpbmcgb24gbXkgbmVydmVzIHNpbmNlIGZvcmV2ZXIu
DQo+IA0KPiBUaGUgR0hFUyBjb2RlIHdoaWNoIGRvZXMgY29sbGVjdCBhbGwgdGhvc2UgZXJyb3Jz
ICpmb3JjZXMqIHRoZSByZWdpc3RyYXRpb24gb2YNCj4gYW4gRURBQyBtb2R1bGUgd2hpY2ggZG9l
cyBvbmx5IHRoZSByZXBvcnRpbmcuDQo+IA0KPiBXaGljaCBjYW5ub3QgYmUgYW55IG1vcmUgYmFj
a3dhcmRzLg0KPiANCj4gV2hhdCBzaG91bGQgaGFwcGVuIGlzLCBHSEVTIGluaXRzIGFuZCBzdGFy
dHMgd29ya2luZyBvbiB0aGUgZXJyb3JzLg0KPiBUaGVuLCBhdCBzb21lIHBvaW50IGxhdGVyLCBn
aGVzX2VkYWMgbG9hZHMgYW5kIHN0YXJ0cyByZXBvcnRpbmcgd2hhdGV2ZXIgaXQNCj4gZ2V0cy4g
SWYgdGhlcmUncyBubyBFREFDIG1vZHVsZSwgaXQgZG9lc24ndCByZXBvcnQgdGhlbS4gVGhlIHNh
bWUgd2F5IE1DQQ0KPiB3b3Jrcy4NCj4gDQo+IFRoYXQncyBpdC4NCj4gDQo+IEFuZCB0aGVuIGdo
ZXNfZWRhYyBjYW4gYmUgbWFkZSBhIG5vcm1hbCBtb2R1bGUgYWdhaW4gYW5kIHdlIGNhbiBnZXQg
cmlkDQo+IG9mIHRoaXMgaW5zYW5pdHkuDQoNClRoZSBmb2xsb3dpbmcgYXBwcm9hY2ggbWF5IGJl
IGNvbnNpZGVyYWJsZToNCi0gU2VwYXJhdGUgZ2hlc19lZGFjX3JlZ2lzdGVyKCkgaW50byB0d28g
ZnVuY3Rpb25zLCBlLmcuLCBnaGVzX2VkYWNfcmVnaXN0ZXIoKQ0KYW5kIGdoZXNfZWRhY19pbml0
KCkuDQotIGdoZXNfZWRhY19yZWdpc3RlcigpIG9ubHkgdGFrZXMgdGhlIGZpcnN0IGlmLWJsb2Nr
IHdpdGggSVNfRU5BQkxFRCgpICYgZm9yY2VfbG9hZA0KY2hlY2ssIGFuZCB0aGVuIGNhbGxzIGEg
bmV3IGZ1bmN0aW9uLCBlZGFjX3NldF9vd25lcihtb2RfbmFtZSksIHdoaWNoIHNpbXBseQ0Kc2V0
cyBtb2RfbmFtZSB0byBlZGFjX21jX293bmVyLiAgVGhpcyBhbGxvd3MgZ2hlc19lZGFjX3JlZ2lz
dGVyKCkgdG8gcnVuDQpiZWZvcmUgZWRhY19pbml0KCksIGFuZCBzZXRzIGVkYWNfbWNfb3duZXIg
dG8gcHJldmVudCBjaGlwc2V0LXNwZWNpZmljIGVkYWMgZHJpdmVyDQp0byBiZSBsb2FkZWQgYmVm
b3JlIGdoZXNfZWRhYy4NCi0gZ2hlc19lZGFjX2luaXQoKSBmaXJzdCBjYWxscyBlZGFjX2dldF9v
d25lcigpIHRvIG1hdGNoIHdpdGggaXRzIG1vZF9uYW1lLiAgSWYgc28sDQppdCBwZXJmb3JtcyB0
aGUgcmVzdCBvZiB0aGUgb3JpZ2luYWwgZ2hlc19lZGFjX3JlZ2lzdGVyKCkgcHJvY2VkdXJlLiAg
VGhpcw0KZ2hlc19lZGFjX2luaXQoKSBpcyBjYWxsZWQgZnJvbSB0aGUgbm9ybWFsIG1vZHVsZSBp
bml0IHBhdGgsIGUuZy4sIG1vZHVsZV9pbml0KCkuDQoNClRoYW5rcywNClRvc2hpDQo=
