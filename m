Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B457E3B5
	for <lists+linux-edac@lfdr.de>; Fri, 22 Jul 2022 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiGVPYe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Jul 2022 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiGVPYd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 Jul 2022 11:24:33 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB999D53D;
        Fri, 22 Jul 2022 08:24:31 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MF8vIe001478;
        Fri, 22 Jul 2022 15:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=jfZIRmZMHcjV0iuQprL2TjlOHZ9hyUCdQUnAF4WbdwQ=;
 b=CNyYkbDOBH1wskPDKf5/g9OAJnYkxxh5Vh0ETIsGTSOEcYn73te+K4vLnppdjEycqePV
 ybW2+j3SC+KFlRmBoNzsNbUjjvYi/F+5eeDLVkw3wuZKihm4/kZgp2jPrGsngv4Theb+
 lq36mc+oJP+h7I8j0tH5h0SIY9PSr0ZrwWFwstq1syQhK0JZ8mGNehNIOb3O1xY4vQEx
 fBeTvbdrhjan4Xf/LlB0uoi2L+2yyjvrM2CDd2FNtgWgcPAZcLuZCr3Hvx04dUpR0FCM
 gyAB1WUVgG0z+SEoDtal3wmMKeMJf/nTPm9Qt4cAVjv6mre1pWTMuLW8q13OO5um4Vqc 1Q== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hfx9cg54s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 15:24:16 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 26F53D2C4;
        Fri, 22 Jul 2022 15:24:15 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Jul 2022 03:24:12 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Jul 2022 03:24:11 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 22 Jul 2022 03:24:11 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 22 Jul 2022 03:24:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEdBhKGu0Iwdn12OsXaPTYjzP3OFe2tcTe9pXpwNb9Td2q70DIW0L6hgyC5g3vulU7CR4bGCg9/fKhvG1cOwqLJgB+6UomkOX9UFgAcoFlJEjc7pNW86oSsfUPbFeQwtnNBhYtfkEjXfdcM+aHfbOxgcHtYH03Hw50L54NrvzssWOfO0NRhKFd9tQ65VIJumWineO9+cS2U0wNXvSq1Rr1AWGSkfEChW5HmCxgmq6PGRP1kXAYL7sitDHTFBlpf1ChobS6tI85fnZVwLveZGwRoUPw/yBVbVcZQjPgUTxeo6TA2kosT9toz6ANPM4IaOg3K9pRUv+UAeMsQWxc7vlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfZIRmZMHcjV0iuQprL2TjlOHZ9hyUCdQUnAF4WbdwQ=;
 b=iHBloMEQqif/Le7DKlxt0E+v00QzMW8XBUheReP+0jsvjObYGeYc9GMeBRH29lDho9OWbg9jTVzXP1ruTwNCpgw8uVvT8ut9dllWpw1AH4k69GX0qudwg6SOmJJGqJZ4hJNFSCeSRQjxI5Qo/MTVEs9LzYgqAvjwjtZ3nk7cEpvzlkpDNM4baaYPCod6Lk3iga6poSwZRZJL7d0lXi2IZ8fXY7Jo4u4iRKi8EdlPcGZtYwtV91OpN5wZnWNZG5v0BvpmGG5ff4n14vtjBxKFfXvJ0cvyRlMBYJ0IfeQNTbXdZxnUYs8k6Nhudo4tpXqU2HJXldSKYETgPcc3nOBuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by PH7PR84MB1837.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 15:24:10 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c165:fcd6:a6e7:3f06]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c165:fcd6:a6e7:3f06%9]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 15:24:10 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: RE: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Thread-Topic: [PATCH v2] EDAC/ghes: Fix buffer overflow in
 ghes_edac_register()
Thread-Index: AQHYnSx3rMQsGJx7KUaiCXMepzwFya2KYV8AgAAhyyA=
Date:   Fri, 22 Jul 2022 15:24:10 +0000
Message-ID: <PH7PR84MB1838067F8BC7CCCE6EBBCCC982909@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic>
In-Reply-To: <YtqkMicKdZdPdUWB@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b16d6978-25d5-4e0b-5d02-08da6bf639bf
x-ms-traffictypediagnostic: PH7PR84MB1837:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /953sQ4OLFVdMjUDRjUz+JbL3vrLlwrofdeyRE/i+emo6yV3MtF0STdkzszrztzzA7TsMa0OM2aqTkwawjp+BZlEgAdEgLBEWz27z4TvbNNKJ87wBqd2AwjFwhRyzzFjsQOKBwsQcODdGseV1NsiFhjzAYTJBvxkZixtGwsauVtwgkRWF7fb8igfrcC1DM9iLFz6LUB13izQx5fdCi+p+YgvR7TxBJZWgjiYie2kcStXzKIP5th79BW8qfyR5nTQj2vY6+7rU0m/gDyd5y8lKsF5Z8c3bZwEMdMb9WOYw5OXPkxF9K7E7Kk5GROasdARw1KG+3DODDYrWdzje13nwyz/zRLmkmp/8yzmRIXlr/N/QOjBgzZhetHJBDhw40dh75M1tUB7yjs/b9JLqAC5fszVuRmsPcjDdQRhuZaKVhSBPqQ2Uvv6Go86VHT1261r8f+KPccxbGGs3a1VeByoiUX7k+6lcZdMhD/5h7obULOc2WjtdnfZzV0shmENzULje9WwO5THmG8CgzHtaPdU4T1OJSUUuf1ABVs3NzubFAxG8Bq3/XuyfrIDdd5zvdQkYjkNML2+fwJhbJx/tyvN2w6eQYEG+OzZ1TjJVJmd064QSplJfjPKJV+cvBCLYJVSxSxAKQCEiuholF90pLfJaKGwk4IE8M8TJC0YGvm1F6GSt/taVrVyH/spWP3pIDed+xATr025YVV8IrtaPNhX8k+LBooXIWac3++9TtqZmvzLDTA0+b5pGOq44+lR5M7FIu4j8n0Myl+oBPzss9tDNMXYHJAcLJKIrFVwtav5tUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(396003)(136003)(346002)(83380400001)(82960400001)(38070700005)(55016003)(122000001)(186003)(38100700002)(66446008)(64756008)(2906002)(4326008)(8676002)(66476007)(66946007)(76116006)(66556008)(52536014)(4744005)(8936002)(26005)(9686003)(6506007)(478600001)(7696005)(5660300002)(41300700001)(316002)(33656002)(71200400001)(54906003)(6916009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anpMY1h3cnUvZ1ZvR0s5bkZwbGhaUXN6QXJoVmxBNjNrWFJnSlpxQzFKTVp3?=
 =?utf-8?B?T0tTdDI2QVppR0liQTdmVGRKeDVBcGhtd1RpSy9qUjFPSjkvMWRscVN0QXJZ?=
 =?utf-8?B?SXA3QmpEVEdIVFlIdm1pT2tvb3Z2OTYyUkROMldWWStsT1ZxZlVzcFJtTCts?=
 =?utf-8?B?M1EvZS9COTVQQmdWR09vdVdudzUyOG16RktnWjd5R0VMd2dKb2lLaTJQRmo1?=
 =?utf-8?B?K2RzMXB4ZUNXanplQTYvb2Z4RjdDQ0xNV1hTenh6NFF0Q1AxYmtSbWdXYjB3?=
 =?utf-8?B?WmdReVhZZ3lmOUlYQ2dPQ0FDZUZIdXpiRGFaVDFDbmFYR2wzTDhUR0lDeUly?=
 =?utf-8?B?RjdJS3JyVDNzajVNVUd3S0pUT0U2S1hIeElrVFcyZXkxc2Q4dDgrNTdRMStJ?=
 =?utf-8?B?enczYmxSbGpUaTJsRGc0YXpYeVQ3bUhFelpTQnhnZ0tBR2F2bVI3Sk40UHBJ?=
 =?utf-8?B?MW0vKzhrWCtTY1YvTWxJRk5KT0hjZllYclJ6TW0vb1lwMllYYTF5cUlLbncv?=
 =?utf-8?B?bkZJQmN5STdkM1NhVnZqc2pPY0hNRWF6dGpYQTQxT0crZGdGQ25DQ1J1eUZX?=
 =?utf-8?B?aEhBVWdwb1k4UHEwTGxXZTl3bjh6eVE3ek1rQmVGUk9qRG5kWWdQSU9PRFRK?=
 =?utf-8?B?SXA2bE83UDBoaWhXMGV3OFFVcGk4T1hjUWw2anRyMVl4eTVqaTRQYVJ1emln?=
 =?utf-8?B?aHE5Y3NSM3cxQUVmQzlKd2VoZ3FBemdVS2VqSDdnUFdlU0hLVUVDOUlnYUJK?=
 =?utf-8?B?RmFXWlMrbk85WjNWU1lMcUlLekc3b0lPekZGUW5SOWgwSkFnRndVVWlQQ0FM?=
 =?utf-8?B?WkpKallCRFlyN1F5ZE85S3hLRXVvSDVvckkvREVFcXdkMHNSbTQ1dGlzTXZh?=
 =?utf-8?B?eGdQRzB3N0dhMjFNQ3RJdTcxaXNaMXd5MzBVSmRWdG8zL0x3bUt3RmZER1lO?=
 =?utf-8?B?aU1UblZvelNwOEdyMnpmSlNMellRSDhIbDhSYnpaT0NJWWFlWmhCZUowcy9r?=
 =?utf-8?B?MTNRYnBvWmVvZnQ5USt1Uml3ajc4OHBzc24vbk0rUmF1MENGclo3ZWUrNjBS?=
 =?utf-8?B?cUxFMjUvSytFaWxzaStWQldXbXU0dFJ5LzJuaDJqSmdMSkp2dXFqMlc3bkIy?=
 =?utf-8?B?TWRMVWJjK1dOTXlLcyszNTVrZVRVLzVpcFVLenhidTZvZTBxTThrN2VJaXpW?=
 =?utf-8?B?cTNITTErdVg2aS9Id1NVVWd5elpKWTBlWVpSUlpSNEZQeW5RdllFV2JqOXAv?=
 =?utf-8?B?aFBrZ2NuV0xGaHFySlA2S1A4eFI0bXRpdjRhRFFReWNSTWkrazNDSUpWL1RN?=
 =?utf-8?B?eE9LeEJNM2hyZEY0dWlzcWtiL1BuejNibUFzVXg2aFNLVXVlYnRoOG1xa3R1?=
 =?utf-8?B?TVFmUFNzL01sRWkzMXVLREVvcHFXbmwweUg3Wks2cG0vUTRTUUVaR1NmOWVD?=
 =?utf-8?B?RldZQmdLcVA1RDlmSEpqRlNzZG9lRkpmWVp3eGM1SzFuUi9TdmVNMlFVQWx0?=
 =?utf-8?B?UmoxdTdubkVpT0lna2ZUS1pTUXFjMExpdlI0SVMxdHdYWWZzSjBtR2k0b3g4?=
 =?utf-8?B?dFhBOXZVVjhWdUJhTjZGN1l0aWFtaE1yVjJHY1BScjBEcFFlbkIvWnBDWkhO?=
 =?utf-8?B?SExyTkhhT2lrclhneHZuVDAxVElDenhvakpydURiZUdjZ01McisyazNoZzZL?=
 =?utf-8?B?VDVkNnJEZ0llcFFSMDhVRVJvSERlNVFBeXROUEs0c2trNEoxbXpldFdhRlA1?=
 =?utf-8?B?YnhiSEtIQjllZHYrTzA2Tm1zd3I1R1p4VUZieWpuOWg3SDNPRWY0QVBLZU5U?=
 =?utf-8?B?UUVMOWVEekJtK2t3RkRBMkdlMTVpYW1NY3B2bW1MR1ZVRlUyQ1pra25LbDdU?=
 =?utf-8?B?TE1GNzVRWWhuVVBWVjdTRTMrbEJGRDZaeHVTS25VZThCRUI5djJDYVlTQ2N1?=
 =?utf-8?B?eDYxSlRrUmlvcVZaWGdXUnFVbytIZC93enl2Y2NEaFp6dVpsbmZQSVRsMzN4?=
 =?utf-8?B?MGQzaEIwT3FTazl3OG5UOGFLMHlhVGJkTS94c1BPejcvalgyT0h2Z1B4Vldo?=
 =?utf-8?B?NzhFNlBzRkxWTnVqeFhHKzVXWDd4ZG5rV0JCMkNpQ0ZYeGhac2puZ28rYW56?=
 =?utf-8?Q?BirHDkwAm6DmhJ2tPUP1wUiVA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b16d6978-25d5-4e0b-5d02-08da6bf639bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 15:24:10.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9JMbFY2RGzuLRW/Pzrr001DYPvfQXYeiIZqCKlnMeEeX477HSQRauloq58gaevYQmC8OheFmvqNJOfa14U6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1837
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: u-pdviMaKYv-SAJtD4JH0WyEiAEKArQL
X-Proofpoint-GUID: u-pdviMaKYv-SAJtD4JH0WyEiAEKArQL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=617 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220065
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Qm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUaHUsIEp1bCAyMSwgMjAyMiBhdCAxMjowNTow
M1BNIC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+IFRoZSBmb2xsb3dpbmcgYnVmZmVyIG92
ZXJmbG93IEJVRyB3YXMgb2JzZXJ2ZWQgb24gYW4gSFBFIHN5c3RlbS4NCj4gPiBnaGVzX2VkYWNf
cmVnaXN0ZXIoKSBjYWxsZWQgc3RybGVuKCkgb24gYW4gdW5pbml0aWFsaXplZCBsYWJlbCwgd2hp
Y2ggDQo+ID4gaGFkIG5vbi16ZXJvIHZhbHVlcyBmcm9tIGtyZWFsbG9jX2FycmF5KCkuDQo+IA0K
PiBJIGVuZGVkIHVwIG1hc3NhZ2luZyBpdCBpbnRvIHRoaXM6DQoNClRoYW5rcyBmb3IgdGhlIHVw
ZGF0ZSEgIEl0IGxvb2tzIGdvb2QgdG8gbWUuIA0KDQpUb3NoaQ0K
