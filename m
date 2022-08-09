Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE958DB49
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiHIPkJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiHIPkI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 11:40:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC3C5A;
        Tue,  9 Aug 2022 08:40:07 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279FdBG8030737;
        Tue, 9 Aug 2022 15:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=CmkmfimM1FvKpZmgDoaXTWg6+L+YZM20PZZSYyMuXiw=;
 b=LkjiNpqtvGb+XGJnqRfKtE2g6QduWZUzNvjKHdQf9XzvCDU9T0aNEGdBWxgQVSY6zaIe
 kER8MfAPspA8rKZDQYZeK43Md5Olur1SDl/lYONUCp+J6lQf8xH2bLWCrwCMM4W10A3o
 FSNQsZnLSu43Gmv7tLiA7vMVJqNMiXuDrnprxbprVjaGpHdySizYXXwrcV75VrBAkTw6
 GtJe/uKR+QIecuItMXfUVzyrZx8uBShy9OiRnmo+ZYGLT7zv68um8vDwZI9/p1HMAXjM
 I585FA0Qs0Ampz93ftZ4Gem1m3zudTP4MEHB1vol6NxBST+Zn0HjIWuYChTAeVUqjsgI 4Q== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hutdpr0yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 15:39:54 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 97137D29B;
        Tue,  9 Aug 2022 15:39:47 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 03:39:47 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 03:39:47 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 9 Aug 2022 03:39:47 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 03:39:46 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM8IK4cEESSlTWLtffgzsRurRLaHrDwhBKma/3oKaq7daTAA/82V/1hqOVSEOOxs1ZcmrICR4soi9OGyWYrhJK4HX12TIQrls8qA37NGNNRbjfTtyCG/3OF3JRZEm0i+H3j7lkSUmMUUGKbjCEroW7FLm3yCzvE8BDn3jglq2QE4t7IHHUbZWl3N/H/BRfiCm1jHUlL4dNeuWiSN1WEGeNvAuc9u69+90TsWJozgDQ24FFoTl4+ALgpa/y+SdNnPNwHl0gKJCGCJHRK+oTYAnDdVHvnAA6gKsTEo15UEKbWO5yGyQsiZ2gweVYCrGNnHqaxgULI5eKNMviud16/OZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmkmfimM1FvKpZmgDoaXTWg6+L+YZM20PZZSYyMuXiw=;
 b=VD9ikkcXOdP4bPJbFaii7+HzmEF7D7gXCXrerLkwrDdgAetUviqWk6SNoAgGibbNZL3uvIANDnYCbxhPdFeRVczvqHRkXrZUxWlsxwpNH09o7u9KJce4+kXfdPrddDohQxBi7CxXIW/tP9QXClOfaPfeJu4o+f3DK1fPhCEykZyexwpVfJX28ArH+og5JrMGKlaQOVdsLTxmr/KkjBI0/hV04+TTUp7izPJcZ8N8/O3CRB/HAgSMixaihVGOPP0wAlQQdgG6LNlXeyhGunG0i2rIH+n5YLcJWrkFu12bHydLEB+4mVmh3YWz8KDqK7/uoFQ1MmDNU5Gr5ZN2JTWdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by SJ0PR84MB1699.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Tue, 9 Aug
 2022 15:39:44 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 15:39:43 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Justin He <Justin.He@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5p?=
 =?utf-8?Q?t_ahead_of_ghes_platform_drv_register?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk6IEFQRUk6IG1vdmUgZWRhY19pbml0IGFo?=
 =?utf-8?Q?ead_of_ghes_platform_drv_register?=
Thread-Index: AQHYq1YbHdpOiV0alEuUJHkPzB7Jbq2lceiAgAAKR4CAAADVoIAABbmAgAACeaCAAKrLgIAAHP6AgAAfFoCAAC4DUIAAFJuAgAADHnA=
Date:   Tue, 9 Aug 2022 15:39:43 +0000
Message-ID: <PH7PR84MB183802388F7CFCA317D3793A82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
 <PH7PR84MB18380596CA00597E9D5D18DF82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvJ5xxsDxC4q3fJB@zn.tnic>
In-Reply-To: <YvJ5xxsDxC4q3fJB@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03c29bce-b13c-4ba9-7b50-08da7a1d618b
x-ms-traffictypediagnostic: SJ0PR84MB1699:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZKSsbMwvOjcwdkjsQ2f1uQfI9EJB3/2lmk3q1jOtDzknEAsPVfy22nprOZENNL/hNyXIJoAP6hPnoHxS3qSXbpHZZJUHhhnNtYKsfd4B5rX+3HuE9eNmFPrlrNNeG4wDmj+Pzeu9XNW4RpINJqXGtJFSpzV1RwT2I1aEwkUqC35jgRCozpmjM7ZcdaBVefjpUU/0uB5AOEEe+sojCAipbHEuTmSWurLZhBrSUxSQG5eCNqlPGxEc7cqlHDUVObucGFCgzk6OhTCll3y1JMTMrr8aMhQ/sp2uUyzuXI5WpQg+mO6ICFHNl+9Zm4JyydQb6JGd1AltvXKiLqWeu+RBpTnm5Jq4lNJMZlZtAiwx8QZ9YNDhATtMNENQY54CdRb9oASEy6fo1dR8CuZjtCZ5whHFo1nVPeZ8aX9IJHlh7m9qwTNohvGRzCaVZvgKQ8N47VWfeAgxGxTrGDxXZEHFMEyg0VNzyADIb5gXTBreF4N2Xa/WqYBLq34rGyg+DW0VHHjOpEGtF0cdH+M5xM7R5ociq3dw0XPDJShCUjOiE2nm0f+coaluYWrCWe/plr0iM4ULZC3GrlqmSV1Bkc+WMt5ZebG5jDkB+UUe3NLpIkUWZnjrHCA1f2LcLNPZ1SlMG8lxWnZHhOvUzjLlRgOrdAOSEKcbG5c0XhFHXRIv3uwtYnGjsSQWax7KsRfuvSjXnXUfpCJdZzgR4iwikRawNgxQO2cvvyZxZVVKFZb3fp7OVHushAYGDtu0nUrdx0yrHGO9xtOEiTLTMzw94dACSE5Gsqqz7PPf/qiC+Zda/2ARCDCFZMAOtTeqPPdwpQgd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(376002)(346002)(478600001)(86362001)(41300700001)(224303003)(7696005)(6506007)(26005)(33656002)(5660300002)(71200400001)(54906003)(6916009)(186003)(9686003)(64756008)(52536014)(4326008)(66446008)(4744005)(66476007)(316002)(66556008)(66946007)(82960400001)(76116006)(122000001)(2906002)(38100700002)(7416002)(8936002)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWFKVG1QbTlGLzN3SXdObXZNTHNXemdJYmZIYU9iYUY4OEQxYUJtN0N4Qiti?=
 =?utf-8?B?RFZ0NFBZNy9YMk1zME1NbnJJaHFOUzhmY1ZZb2owS0ErMG1Wci9qbWpOY1Ru?=
 =?utf-8?B?ZStxak81Y2JQOXRRWjFaV2R5NHRQaFV2MHE2NVcvMlk3QTRGMTlrdDlhOGhB?=
 =?utf-8?B?Zno2Rm5HRUsvV3ZtcFF0UDdITzlOSmdBSkpSdUhEVlpsQjNOL1FLdEpxZzBZ?=
 =?utf-8?B?NGhhQXRlK251UlVicC85bXNHYVNmb2syOVBlcXFtR2YvQzR3SnQxSHhUUFlY?=
 =?utf-8?B?bzV3UkE1TllPTi9XZHJTSk03djlQR0UwWFc1cVlMd1hvN1NpNkRXZTAySEVt?=
 =?utf-8?B?RG5hZEtSQXZkSW4velJnMGNMbUQ5UTAvb0IyOUgyWE1DeGVhWXZHNlBLemFk?=
 =?utf-8?B?TUNEb0JoNHlmcTVvVnk1WkorN1FNeSszTWRsWUxuOGprNWNBVU9EWEhWYVBG?=
 =?utf-8?B?ODUraVhQK0NWU0ZRZWZsM0ZNNERIcllia1BsVmdxTjNGZTFKRlF4T0dZRVZs?=
 =?utf-8?B?akFWcXVQZVFvSWdiZTZGdlduK1M5ZThFR3pIMVNBNkNJMTB1V05hdHBVZFNR?=
 =?utf-8?B?LzdvaFA4cFlUMzIrNENzMlBCZG5SSHp2ZjRKb29lcTFXQ28zTjJqR1Q5cFM1?=
 =?utf-8?B?dzVIR2ZsakdTUU1yNkR6Y1JxamVWU29vMEowVG4raS8vaXhIQThodkVFdzM0?=
 =?utf-8?B?NENyYTB0V2xpR3czQkZ3QWJjZXJWM0Q3enV0dWdXdnBCOHBoSk1BQXhOYnJz?=
 =?utf-8?B?aTFCYlMySCszSnJ2UVRBTjhEQ2QrSC9kUXN3N2ZscFhQd0FCbzVyM2JhWDhj?=
 =?utf-8?B?T3E4Uzg1ait2Wk4yNFNieElVeFZwVmh0ZUNZZ2tERlUybi9oa0FBVklVcmlU?=
 =?utf-8?B?UjcxUVJBcDBuM2dFdHE4MjU5VHBFMHU2aUt6SkpTVXlHL2NSdlpzdDhSMU9W?=
 =?utf-8?B?SVM5NXU4MEkxenR1YnBYK1MyMUJaR05uRnFEc3ExZDhuKzhNc3ZwYXRaNno1?=
 =?utf-8?B?d2g0azI3WERYQlNyczEra0JRUUtaU01tcGNyK1ZmejdpN29TSWdqRHMxREN1?=
 =?utf-8?B?bHpTeHk1ZEJKSURnaHlBLzllNGJVQjBJdEEwcXpVcHZQQnRZVnl0WTN0cXRh?=
 =?utf-8?B?Q1lHdFFnK0xLdmRXd2lTSWliRm9sekVSUjBMVFUycXhacGZRUGhCOGYzWmlO?=
 =?utf-8?B?TTIyMEdlWGQvTmxJTVlNemRjTzNpYmFuaTdPa0lQSUJxQ3pKcUlCc2E3TWdB?=
 =?utf-8?B?QXRicFhHQkV5ZGl1cFYvOHVoWUhxZW1BZ0svSlpUV0x3L0liaU82dnY1ZlZK?=
 =?utf-8?B?WG1GUEZrWHhRQTh1TFN1TFc4KzF3b1RmMEZEdGk1WTYyMThPMm1MemR4ZnpE?=
 =?utf-8?B?azdWeExLN1FpNVl2Sy9YaEJnNWo2ZWJJS2NvYXJKbUZHT2dqNkhQbElaZXd6?=
 =?utf-8?B?bUV5eW9VUG1lUnlYL0hsR2JLSWwxejZyMllwa1JVT1dyclRsaU5oTElHTi9P?=
 =?utf-8?B?MGZLREhKZVcreXI1aVBJOWRRWU8xaTYrTm9YVi9kS1JaYTlyaGNhU3NMM3Vm?=
 =?utf-8?B?WUVDRExqUTBTTkdzY1NJL2RMRlM1Rmt5OE1TdHluUDdHSUJVV3orRWNSNEpx?=
 =?utf-8?B?OFZzdFNDem5EMkdVL0dPdTBxMGNBc1dhOUxpdmExYklvenN0dGo4Rm5rR00v?=
 =?utf-8?B?NzJSSFBCNFNzL1hFeGZTMHdQWWJxOHJhdTN6QWtYT1F5WTYwL0RkSktONmdR?=
 =?utf-8?B?eVNvWUlFZkc5L2h5TlFYNHBNUjVQeW1idFFTSW8yUnkrME9qVUNVOEd1eEZa?=
 =?utf-8?B?eDlGYW1qVUkyQ1gxYUVGc25TK1JzN2NXd0trbHlEaGFCQUgzRzNZWUJBNDRG?=
 =?utf-8?B?d2grNjF2ZXEzQk44dEtEeFlYVUhBdlVwb2tveUN1WnU4VytQdlhkVU5nTVRE?=
 =?utf-8?B?aU5UNHQ4azVUMWtvTkJKQ3pkL2h6MFAvRUZEb2hreVgzSmZJbGNJQVdSaVlh?=
 =?utf-8?B?V1FrUG50UTlCUXJWN0FibTdYaXArOWNsLzNvcFNCNWkxeFVoQ1A1cTNIV3pM?=
 =?utf-8?B?RVI4VGo4UDViNkpSbVVoV2I2eURYL2kxRnlqNlJTYkU0MFVFSFgxY1JMRVZy?=
 =?utf-8?Q?Yhjk1/7Bq/Wf2JdKlL+/3fDoX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c29bce-b13c-4ba9-7b50-08da7a1d618b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 15:39:43.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rEcVIAcu3BedrXiMOGlyatln0qVq/Uawu2LrR9FTCpAzUQRFBdBfb+XKr5/YeasZWCiDbiEeJohYVWnPBmFbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1699
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: d0NligDa7-sev5OhWSX2g0QyvAQPQhuH
X-Proofpoint-GUID: d0NligDa7-sev5OhWSX2g0QyvAQPQhuH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_04,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090066
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gU2VudDogVHVlc2RheSwgQXVndXN0IDksIDIwMjIgOToxNCBBTSwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAwOSwgMjAyMiBhdCAwMjozNjozM1BNICswMDAwLCBLYW5p
LCBUb3NoaSB3cm90ZToNCj4gPiBUaGUgbG9naWMgbmVlZHMgdG8gYmUgbGF0Y2hlZCBvbiBnaGVz
IHByZXNlbmNlLCBpLmUuLCB0aGUgY29uZGl0aW9uIGlzDQo+IA0KPiBJZiBHSEVTIGlzIG5vdCBl
bmFibGVkLCB0aGVyZSdsbCBvZiBjb3Vyc2UgYmUgYSBzdHViIHdoaWNoIHJldHVybnMNCj4gZmFs
c2UuDQoNClJpZ2h0LiAgSnVzdCBjaGVja2luZyBzaW5jZSB0aGUgZXhhbXBsZSBwc2V1ZG8gY29k
ZSBkaWQgbm90IGhhdmUgaXQuDQogDQo+ID4gQWdyZWUgdGhhdCBjaGFuZ2luZyBhbGwgZWRhYyBk
cml2ZXJzIHRvIGNoZWNrIHdpdGggR0hFUyBpcyBhbiBvcHRpb24uDQo+IA0KPiBOb3QgYWxsIC0g
YWxsIHJlbGV2YW50IGRyaXZlcnMgZm9yIHlvdXIgLSBIUEUgLSB1c2UgY2FzZS4gV2UgZG9uJ3Qg
bG9hZA0KPiBnaGVzX2VkYWMgb24gYW55dGhpbmcgZWxzZS4gS25vd24tZ29vZCBwbGF0Zm9ybXMg
b25seSwgcmVtZW1iZXI/DQoNCkkgdGhpbmsgdGhpcyBzaG91bGQgYmUgYWxsIGVkYWMgZHJpdmVy
cyBvbiB4ODYuDQoNCj4gPiBJbiB0aGlzIGFwcHJvYWNoLCB0aG91Z2gsIHRoZXkgd2lsbCBuZWVk
IHRvIGNoZWNrIHdpdGggZm9vX3ByZWZlcnJlZCgpDQo+ID4gd2hlbiBhIG5ldyBGVyBpbnRlcmZh
Y2UgRk9PIGlzIGludHJvZHVjZWQuDQo+IA0KPiBJJ20gYWZyYWlkIEkgZG9uJ3QgdW5kZXJzdGFu
ZCB3aGF0IHlvdSBtZWFuIGhlcmUuDQoNCkkgd2FzIHJlZmVycmluZyBhIGh5cG90aGV0aWNhbCBm
dXR1cmUgY2FzZSB0aGF0IEFDUEkgR0hFUyBtaWdodCBub3QgYmUNCnRoZSBvbmx5IEZXIGludGVy
ZmFjZSBmb3IgRkYtYmFzZWQgbWVtb3J5IGVycm9yIHJlcG9ydGluZyB0YWJsZSBnb2luZw0KZm9y
d2FyZC4NCg0KVG9zaGkNCg==
