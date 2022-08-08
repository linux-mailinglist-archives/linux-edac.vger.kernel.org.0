Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940158CFC8
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 23:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbiHHViO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 17:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiHHViN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 17:38:13 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7531149;
        Mon,  8 Aug 2022 14:38:12 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278LbHL4029986;
        Mon, 8 Aug 2022 21:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=dwkrFkOYqutgTZoXLZZQOD5ngiCVOLghHGOAp4FKqZs=;
 b=U+kSDeYNla4k1IAyoUeQUARkW3+Y61n8Sipxdz1uZzyu1ZT1gNt2ecMlw+a1M/qdagVy
 lZY6LLhKwLM2ayy6oJ7wzoY12r76lp9rHtcRK3yKmPkqwk05wbOFcCgUtUrNy/xq5A4H
 zc1rJ6EUYHyR/QxLKJcV5FJhIRsSHitCNnMOiCsq8rladJBabohkxRurROBQbLZGKZbl
 IqCZXDfCqKgRTTmhQed37XxPP07OpWFNagFOjig5dxYi1TshoRhh3WqmigBw8XHr20gi
 ihRRGwDgeHO8UPAJNorErWOuf0TI9tO1NEIia5Q++e7bCflqBQ+5SHtuw1BqniAr1GDs uA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3huaf9020j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 21:37:59 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 81BFB801AE5;
        Mon,  8 Aug 2022 21:36:46 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 09:36:16 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 8 Aug 2022 09:36:16 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 09:36:15 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL4e4hWZd7lUHnAIMjRywOAHmcW5o9yX/EKaZE24R/CWbNMZcTaqgrp/3rbdB0KCu1zn4IIT9hqClQc4c/WP6/hyB3F8wyH+X/EhPjxpkmMU0yBE9N3rK8OJkM3Xw/9mQXNLWuq2IEAyEOx6v9oXaNyWVWsDoOaKJ/XmYqz1Lc+eRpprcBrJeuEg61Nytay4KyoklmssoVJJcnr6kUnJ+Kb1WqUtodP0vZRURqpBIYThaLtIb0lWSomdDBqB3TVVH6b9cWqSZE0PbixQzJd+d/bWCHjl9C0OkWNWTa+pti7SDqEB2fdfaYIFgA51Gnp3Iv3xbgjb6OhgzgfzeARtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwkrFkOYqutgTZoXLZZQOD5ngiCVOLghHGOAp4FKqZs=;
 b=VhLyz6mHJ0h+vxuCWln1EZqefY+91QU2AMSbPR+WX5PI7Me1B49sdVpch4KU02+WM0cB0Du9qbSfxG8Z6TowpTnXgO24f8YeSN8V1yCGgm75A1SsvE9K+prKAyiUIm62gPbgdcTMWJuGlzpYZVY+ELx/7Sk7ncTbIh5d02aHmY2X1oBCFwsFBt50rfNebH/ZubPQoHzAeZL9f6aR3ZvGGo62C434DFNldkatCGBU3Ia0zBRr6le918OP8rxAyHdovkYwUEIHqR5qW9ZH0hNtmBLYqSa+k4eIyHgcMQxERJPb1JSE2W86jn43MeyAbP63oKa7iVa8qpdMhAnld1DzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by PH8PR84MB3236.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 21:36:14 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 21:36:13 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jia He <justin.he@arm.com>, "Len Brown" <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Thread-Topic: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Thread-Index: AQHYq1YbHdpOiV0alEuUJHkPzB7Jbq2lceiAgAAKR4CAAADVoIAABbmAgAACeaA=
Date:   Mon, 8 Aug 2022 21:36:13 +0000
Message-ID: <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
In-Reply-To: <YvF+J/dfyOEVSbSQ@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2339aa2e-2299-4b3f-3d47-08da798604c3
x-ms-traffictypediagnostic: PH8PR84MB3236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uooslA170vyMSABNJaeFEOMXLAa5ZquZGpuKsmBrYw1t0BkR1lTndn3AlfdCloKn4aBpqxCJ9qdgBqI5bBJ+6Z9tmK9/BV4UrEX4YaEdhibDeZGBQOP5kc8XXMru6oit6wTIcUckh1osrOWwyPzzMfyRwuxZYB7tyoz+jcs6IZavRKoSIi5Q0g/xVtP0S6SpZei+PQf5GboS34kfkoHMnMh6ZS/6uEzdzghUK7vlBO2pnjH0f9g1rsZYpW9VCZFw3P1ndlcAklOBFHyvw01C6XtnhL8TorztbGGH79S6WIf0h35tMi1aoIu0T9EAiSXnbfrcSH8d7hliIRNRAu/NdwI20faWKzFgnKN9Cih+Y1Ex/cqeB6QKtHmPAfxcgfJhwFYnchgJ04N2Q/XJIllKxaJ3K5ZckSGpX2HHk9XN1+4ZqsgvbOF7p9pU2R9YiICs1OHM3Mcw5n2AJa5GcaB/kSLGoW3VFNP/2SqlRwoNoRGngOwB/3kG7WnN/gAg1+FLG1bpeoOp2+SS/BUrMHPbO47KYt12xDqxwsoacBXOFl1IFfhNZ5LhKjtJBse5qJ4576eTpBhpL1jlmN65xaVDmcS7rWQY/AT6YtlMEB94gX3UNk1gvKC5Tyh/so7pOSsmvNvIAhhB2bPhtwpRy+bLm0YE++PtdIa2ib/f8VoihwKkOfH6tEVEDDEUxLY+nVnw3Xe+h2cFV43b8Wv1Y3BluHVgi4JZDleNZuMHAtD/tnEMf16J0c3+WUgN78LwIj3rWMrsEZIB16k4omhuWYA95nCMPQtVprQA4pcCTQt+g70=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(396003)(366004)(346002)(4744005)(7416002)(5660300002)(52536014)(2906002)(76116006)(66946007)(33656002)(71200400001)(6916009)(316002)(55016003)(478600001)(54906003)(8936002)(122000001)(38100700002)(82960400001)(38070700005)(41300700001)(86362001)(26005)(53546011)(6506007)(7696005)(9686003)(4326008)(64756008)(66446008)(66556008)(66476007)(8676002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU1pZURvU1dyM1RRY0lkWkhuemVJelpXU2NqM3BnSW0wMWdUVEh3WUZYMWlq?=
 =?utf-8?B?QzgzaG5GNE0zWndEUDRqUzhaUTVVTVNxNkNMcW9iTUZyWFMrMjBaVXlkSzQ0?=
 =?utf-8?B?cXNPTFRid01SZTU1UXo3ZU9wbklnbjE5aUF2dWU3V0Z1NFVsbERYRXR0TVlv?=
 =?utf-8?B?N0VuM2hHWVpmc0I1NWpkMFZjQStpbUl2UWZVTFNhU2tlSklVRS9jNXR4cnll?=
 =?utf-8?B?czNValBQaUMwSUVnYy81TmZvZFJxdGJCS2tWNzljK0lpQmxIOUhhRDFmZHc0?=
 =?utf-8?B?dHhvdWtLUml1L1BYS3VNY2RTUnhibElsNzJuWHRCT1p0bHRvSmpRV25DSWhK?=
 =?utf-8?B?bmxoSDk4Rzl6eTBPVmVxS1F4bU5ENmVZNytZNmNlTWE2SjVvRVM5eHdzM01Z?=
 =?utf-8?B?MFBsMjRkL3BPZm9Ha1Q0ZUp0YTRRMGxZRnN3amJNZlI2YVJTUWJFYllyamFo?=
 =?utf-8?B?RzZPVEdpZ0ZOMHcycWNoeGwrc0dVZGd5L0IxNzYvaHE2RzFNcHdCMXZVK3p0?=
 =?utf-8?B?UTZsemo3eDNYN3cxM01RbFY5Nm1aSnZLUTN5NjBoV0ZzUEZqL2M2VENsYzlp?=
 =?utf-8?B?bGN4QlhFbTNCSTJWb2ZjVGc2UHlHcTRXOG0xU3QrSE5DcXJVMW1xR1NzOWw2?=
 =?utf-8?B?VUNLYzNlc1Q0NXdXUlRkQS9NVnlNWFk2Z01LbmtVQ0w0ZkZnTVViaHk1OXVO?=
 =?utf-8?B?MG16SWNIUlBGS1o2eFJORW9ldzBEd2FSd0Q1YWM0RURreFRqa1puK05NdkNM?=
 =?utf-8?B?a0tsUDl3Z01TSzNuNGNvT1V3YitQUUFDODYyOXRGU2ZpeFdzN0EreFBGTVAw?=
 =?utf-8?B?WU8xQnVrYnQ0a1JwcHRSbVJSMys4MXlKMEpxdXBmWGpGVGFwQWxHWHhSNHFs?=
 =?utf-8?B?aUlmNCtESmEyUDNOVWNvMklxLzdJKzVCVEdDSyswZVVCUmdldzgrdGF1Ny93?=
 =?utf-8?B?b0l2QXpQS2JlY1Y3K1pDQVMyd0JMc0cycDE2U1k4S0QxQ094c00vL0s2R25B?=
 =?utf-8?B?VWZ5RVV1bkJlU1pDVXFXR3VSRDZXcVVtalpwUzBDVHFzZUdCaSsrYTBtanYv?=
 =?utf-8?B?L3BhakNGZWd4WVRNV3dxQWtueENCZk5WQ3FuR3ZQbWZ6OXdTQUhzeVNMbE5N?=
 =?utf-8?B?NTJka1VvMVZYWGZxajJTZUlwVlU1TStTcW12UjJDK21DbFlaZ2thZStkOGZ0?=
 =?utf-8?B?ajViZmFhTmZsTXpLUTlDVjNWVFB4TnZWYVI3eVV5ZFZLQm9xdzZkM3BTYXFw?=
 =?utf-8?B?QzVyY3pON3VzaEhEemtoZmg3SHoydUt1Wjh5MHRnWHRQS1V3SEVzQ3IrdGxu?=
 =?utf-8?B?anROS2FsaXIvYThHaFBET0piYU9yc2dvWGVxWlhrYU91TFBCRFZmQjZXTGVQ?=
 =?utf-8?B?T1pLWlVnY3NiZDU4dGRaQ29KRENDeHlXelpOYWFRd0hRZFJ0ajAvR0JKbS9v?=
 =?utf-8?B?RlpYcTFFUE9vejZlY2R6ZnZRVWRvMUZadDVRRXlBUmk2Q1h1R25OY2c3emRJ?=
 =?utf-8?B?OEYrQlB4YUZZTHhPMHN6WXBqOW0reUhaWGJseE9wSVVPeXFpS1oyRzJJenU5?=
 =?utf-8?B?WUFBM2lOL042cmRuQ211RUhnUS85ekhxV01EbUtoOWxUcmtNNUE4YnV0T1VZ?=
 =?utf-8?B?OE1VOXNrNWtkV0UrU3YySDUwNjEyWXM0TEV0akNoQ1B6QThRdFJQVEFpcXNy?=
 =?utf-8?B?QXZCdjhwZEpIc1liZWRyd2lybUxZV2RReTdoRzNqQmxlcFFhN0kwUVF4WHpM?=
 =?utf-8?B?WG5lR09SQTJ3aW4wOXB3M2FhME9OVmYwYm1WUVZpVjBmN2lDYmc3MkU4QkhF?=
 =?utf-8?B?L1dpNU0wcVB2NmVQQkJUKzlRLyt5QnhkK0Z2V0tCSVc5WExKRHFJc3NpTkdy?=
 =?utf-8?B?aytVRVR0TEdxWlNMYmEwcHlMRFVPYjhVNjROeHJIN0ZXR0RNcEk3Ums3ZWRQ?=
 =?utf-8?B?VFFoWUxLem9CVmNCb0g3L1VwUVpqemt2WWk3UjM1NXRtZHd2UUU1alB4QXB6?=
 =?utf-8?B?T1NaK3oyaTZkT1F0WXMzOXE2M09hWi82SGtObGltMlNTU0lZdTZBd1h0YVYz?=
 =?utf-8?B?MS84d3p4bzkwUTBBUEQ3dG1xOXJ5RkIzL24wT0dZODRVcStnY3NGK3Bmb2NG?=
 =?utf-8?Q?zOIMuSnBaYDIya8wLIhxR4GTZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2339aa2e-2299-4b3f-3d47-08da798604c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 21:36:13.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxpPXq39JAeBviU/SWc3C/oaOHvMMC5yJiMa5MKCgc8TVrXC6WHfXg8AVNukXK+7uhcQSLKluYmdjoJlvE8xLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR84MB3236
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 1ezJrMJAuo0RsV6rrLKZxYJ8chDHwCeh
X-Proofpoint-ORIG-GUID: 1ezJrMJAuo0RsV6rrLKZxYJ8chDHwCeh
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=661 bulkscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080092
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgOCwgMjAyMiAzOjIxIFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDA4LCAyMDIyIGF0IDA5OjExOjUyUE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+IFdoaWNoZXZlciBsb2FkZWQgZmlyc3Qgd2lucy4NCj4gDQo+IFRoYXQgSSBr
bm93Lg0KPiANCj4gVGhlIHF1ZXN0aW9uIGlzLCB3aGljaCBvbmUgKnNob3VsZCogd2luIGVhY2gg
dGltZS4NCj4gDQo+IElPVywgb24gd2hpY2ggcGxhdGZvcm1zIHNob3VsZCBnaGVzX2VkYWMgbG9h
ZCBhbmQgb24gd2hpY2ggdGhlIGNoaXBzZXQtDQo+IG9uZT8NCg0KUGxhdGZvcm1zIHdpdGggQUNQ
SSBHSEVTIHN1cHBvcnQgc2hvdWxkIHVzZSBnaGVzX2VkYWMuICBUaGlzIGlzIHRoZSBjYXNlDQpv
biBBcm0uICBUaGUgeDg2IHNpZGUgaGFzIGFkZGl0aW9uYWwgcGxhdGZvcm0gSUQgY2hlY2sgdG8g
cHJvdGVjdCBmcm9tIGxlZ2FjeQ0KYnVnZ3kgR0hFUyBGVyBleGlzdGVkIGJlZm9yZSBnaGVzX2Vk
YWMgZW5hYmxlbWVudC4gDQoNClRvc2hpDQoNCg==
