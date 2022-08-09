Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2344958DC76
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbiHIQwF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiHIQwE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 12:52:04 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715EB15713;
        Tue,  9 Aug 2022 09:52:03 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=UUuDa5eyh28CySxk07GkXvtmhcRJkcBGM+SlXVGr8rIR2Ygw6jfrWqn3uWOIn8Ahy7eGZAghZU5c9Sfrgdm2qTfltiRn4l5rGNhqyKfQzLRWo2IMtH6D/AZgs77qfA2ypJJcBIuMsx30in/SFTFJYZFHR7f+iI7nppZu4dh9oVvg+RIIfaiqaHTtwO0FoHNJYk9qTE0X8/UCLOUGc247dChUiyYj7jaeqoCBA1Pg1Pkns9qV743amm4RGZ2MVLMjew1538CL72zq9lMfJQWmnOuwpf9AIrBmeVTfco27EdLc3zL8ft1kW9GEjpMhjWSAGvuc67MfdFGv9q5WtCNbUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6lVewB07pvr38iqcl42DmXeb8P7wNtMdyZ7yK0gcjI=;
 b=H6pefJYXUnLj4gg9sKnNd6Sgf8pjA4QXOzbToQVuWIb1WaxBCoGM7NA7OZIt5F0RcQU4gJMW3DmQSyL8GmU4pZvXOeIYo965qmxY25qXzxbM19pX0bXXZyJTpXvtgxhNh92p9/1U1/xZtLd8TYmdsyLK0r2Mx+YDpM8qwOu98PUufXpj8SnyO+s1NiEbpxWTVjcD5vlX9JDwOWzyeVdxhlnnftMtC6uwB3zfbdt7BTV+FjcFT1lmvEWoRvxBazuvaR4/sb8TnzGpNIXhWcap3PrfgRhNtX1BFe/BhE/csJHVvYQGgLwnaNDDNr8sdp7GbabFl4XRKYylltzyr43ZqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6lVewB07pvr38iqcl42DmXeb8P7wNtMdyZ7yK0gcjI=;
 b=soYj8sv9aKYTEdMFj+2VfinAQK2t7K7aZW0aHcUbLy5p3DMbCHndec8ZXHfi5/nHxvSHv8r7qmVJhaT3QIta2FNf8qGPTfpwQiQ5MeERFn4a+bpsb63elTU18R2/ayV6OSYgkROEuY28JdRfTbTpIMb9cVUhO6j+r5001CNDj6I=
Received: from DB6PR0601CA0004.eurprd06.prod.outlook.com (2603:10a6:4:7b::14)
 by PA4PR08MB6127.eurprd08.prod.outlook.com (2603:10a6:102:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 16:51:59 +0000
Received: from DBAEUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::f3) by DB6PR0601CA0004.outlook.office365.com
 (2603:10a6:4:7b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 16:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT060.mail.protection.outlook.com (100.127.142.238) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16 via Frontend Transport; Tue, 9 Aug 2022 16:51:59 +0000
Received: ("Tessian outbound fa99bf31ee7d:v123"); Tue, 09 Aug 2022 16:51:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d64fd3be0b3ffdba
X-CR-MTA-TID: 64aa7808
Received: from a37328b53477.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 35977A12-B4FB-4F0D-BCA5-C3DCABF0C3B2.1;
        Tue, 09 Aug 2022 16:51:48 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a37328b53477.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Aug 2022 16:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVmNJlGVZSL+HR5XbeWl+J50FnFfhQce5Ni+VZ6yFJzL/W5o7GdIkUnpXqHsrAvxEItKdHaryYf4jThR/cTOd6uhEkTT+QTj46123Lmp1/VMAXaAOCkkAMHqdNY00VsTm8Mq1eM+NEG4VFmMUmPmMPxusARrcPeOvm3KGrFiz6VU0jf/vlTltQxNBvkbhF+KGHd8LEHe/OU1g8PZqNainDi8q8uzLgw9Hbv1QehOZ9MGP3HyVZE5lSqHPBc8EAWhImYkOjZ4dGPt9DOQx2jQ54OdVI2LuozINTf+PrtbjzrFf45H+D25NWVHsgmmoviNEgGdzMNJqwV0SihRIfFz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6lVewB07pvr38iqcl42DmXeb8P7wNtMdyZ7yK0gcjI=;
 b=ZDUfoHAiJGBsB9KdIghVyHU3k8WXetmHz+3FPAWkQBbnF8B22TltMmYGT2R+wAuNHNSebRC49LWH3qu78K4B1fW/ATw1cFt1ZshdEoa7Mqz5wDYvy/WFJi5hwwrDq2B2dQIEHiU6IOk6O+7DJMrn3CCYn1g2mEEV6Ezj9+Muvk7yCloVv+KwQCM2eMDv3M1JGRZEQhV3b7HG1ja5jlWytXxrSYaWfsoqL49yJud2GYHY4RmQT9DDuSApyiUVnRilon6gKo1pI0Ek2pO+k4MjBsL0ly3wzJsAGLzZfRznaI4tTbLlGfPt+xaYQRGGQ3vhlU06M8W7ZERrRz0d+1YLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6lVewB07pvr38iqcl42DmXeb8P7wNtMdyZ7yK0gcjI=;
 b=soYj8sv9aKYTEdMFj+2VfinAQK2t7K7aZW0aHcUbLy5p3DMbCHndec8ZXHfi5/nHxvSHv8r7qmVJhaT3QIta2FNf8qGPTfpwQiQ5MeERFn4a+bpsb63elTU18R2/ayV6OSYgkROEuY28JdRfTbTpIMb9cVUhO6j+r5001CNDj6I=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by VI1PR08MB2974.eurprd08.prod.outlook.com (2603:10a6:803:3f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 16:51:46 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 16:51:45 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5p?=
 =?utf-8?Q?t_ahead_of_ghes_platform_drv_register?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk6IEFQRUk6IG1vdmUgZWRhY19pbml0IGFo?=
 =?utf-8?Q?ead_of_ghes_platform_drv_register?=
Thread-Index: AQHYqHOdT73gyPDB9Uq80vSHBXC6162lVXgAgAAFgwCAACJBAIAABLiAgAAEGgCAAAJ0gIAABFqAgACo6oCAABqDYIAAIZGAgABbUgA=
Date:   Tue, 9 Aug 2022 16:51:45 +0000
Message-ID: <DBBPR08MB453870FA5C5D26AADFDF05C7F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
In-Reply-To: <YvJB5cxSldpigw1g@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: bd291b19-a1cb-4bd5-2315-08da7a277a08
x-ms-traffictypediagnostic: VI1PR08MB2974:EE_|DBAEUR03FT060:EE_|PA4PR08MB6127:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8p9e9IHjQt+REpbzrzrd2e/IzFIf96skqhcRoYjJFYPMbSKb6CvEamaSkmaU77OkvuacBUuOYl+twHXdM684Y/RGRxdwnAljkIupUoLaXMYUdOfkiLHg9zFhboFINI2X5/Dw2nPr+B8XlV/5vytqgN5/57EkKtknBS9JOHEZ+PE1QResRRnWa/v+IqoUqpHMkqNNPr15a3HIgp3dPRpF9gktOhjghbw//4Si/7R5p32mPv4i/kDjeepkFMHIUUj3kK1DM8NFcS+P9yAa9e2DpPKsitIxOn1VA2kWWlry8CxlThoLYqp/P4/vI+6s9yWCKYbtAczKHdY0ucjUDVJF9GP66AuLiRm145sR8W08GWur/htCEKAY3bKntVp31nX1/TMO7ThUzjN00ZaguvC1XCBKV7SWc2H91ddrlhSxwFZTGZZlrE0o1nt30ZwSdnBPb6FStsW0jyFAQVsXPGM6CEt+rwB/6OdcnOYCeDeMQb8Yyu7wcSbvq9NzgOthzjrGdpPnO2Pe4t6P5E4k+qw49pHSB9t8eGq2B79z5bAt+wPDcY1Th0aRTvmKBHzZdCzXqpagZTW2zpUgqVPouK69gkfG0tmlfdt5h7b9me0V2TTxFB1uxslqqgBj4ecB/IFL8XOcddAGn5pH0nnYskq1T5ERGY8daBkCC2Te6hEVZ4+hWHqxsJsmIVP86Wwi59XhmtM/5/yeCcSKt2zRG68eWw+fp+n+bN7t3ni4VzBsfY2wSjwG/qoFYRHmeyHuphb4OGaU86KIh/ev6KYt2w1Eha+7jDzSm0pT9Td2DQR/0D6qH1pkNpLCkaDHwlO1BLa/FUyNewG9a/7un7MW5uKjutFQ3369r5pD9AGsbnMpP50=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(53546011)(9686003)(26005)(6916009)(54906003)(2906002)(6506007)(478600001)(41300700001)(7696005)(316002)(86362001)(33656002)(71200400001)(966005)(224303003)(186003)(122000001)(38070700005)(38100700002)(66556008)(66476007)(66946007)(76116006)(52536014)(66446008)(64756008)(55016003)(4326008)(7416002)(83380400001)(8936002)(5660300002)(21314003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2974
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2bc52187-1321-4245-0447-08da7a27718e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+gfTmxoD0LsR9jgpBqiTUBkr7+vufvfIHlRFOmnvBxN6HdeQV6r4KMTI1Y7K9Wwl45wDNy+KGCf7Qq6UWUGXGc9OMVt8jP2dIzZBv/OHk1QLqXjyDdAsAM2UeszJ7Wo6JKoEUJk3goWixAcAq1U4bWEJrUnz9ioC5EU+m+oD0B5PkzurjFWbBxkN4Q55Pz+uJIbHfYo2pGWjBl0qhiFMmDgc/PyKeS2WQTIgWj3I4pRd/3VAg1SiPBsyuvzt+qFHJyUUWTU6lGWtMvJibHQ6L0Y6Ac6T/KnOwn60SmyzdxiY7M2bD1Vb8TXc3WS3bZ7o6Il6FrDmBFkpLVKVl6s57jJatnm+9oPZX0tC8Ie/bR5DvRg9L6L34qN1HAx64McW1Yl546ej9Y9t3O599J8zctZAZhTY39SzlUQdQUO2VxAROnFhIccsg5FnsV5eD2jA9+qaOMGP22r0hMAAwrnz0nIuD1nmqZwvOn9a6JnMz3Qt/6izBZS2rHowA1/VeqWIgyO6iWbWPneiQk6bhoxmteEAJvtoAdgzt2t2sqBGIRFnFTHGbgcC5mzkwcb1KwAnV7BQ5n7gVLs4OfOUFnN0KF9ijIIn85A3DvAQ5qNE1Bv7cSnhKoH4X5IBnAONQEp/hyOU9bEmOwTeijPbvrZiIn1Q5lAD/BCOHl3QTBtpfM7NldufPnS70LjHjOQ03CPRsnkZOrWYj422U5+gqzzZOM+SsJysDSB2WwvJQqVJ2wGyUGPvnxaL2eHSOFVMlcz4giyo7leSjmW+XC3b+Pt4NkebdrgoBMDnhAlTyafhc6jFZHnmnaeCGeEDh3AN30o3To2DPUkGYkndZde3mX+h7J7B/o1oJuyM87pyWsEIH8=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(40470700004)(52536014)(5660300002)(6862004)(8936002)(40480700001)(36860700001)(86362001)(966005)(55016003)(6506007)(7696005)(53546011)(41300700001)(83380400001)(478600001)(2906002)(336012)(186003)(33656002)(9686003)(40460700003)(47076005)(26005)(82740400003)(81166007)(82310400005)(356005)(316002)(224303003)(54906003)(4326008)(70586007)(70206006)(450100002)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:51:59.5857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd291b19-a1cb-4bd5-2315-08da7a277a08
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6127
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXNsYXYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jp
c2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDksIDIw
MjIgNzoxNiBQTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6IEth
bmksIFRvc2hpIDx0b3NoaS5rYW5pQGhwZS5jb20+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+Ow0KPiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IEphbWVzIE1vcnNl
IDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsgVG9ueQ0KPiBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29t
PjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+Ow0KPiBSb2JlcnQg
UmljaHRlciA8cnJpY0BrZXJuZWwub3JnPjsgU2h1YWkgWHVlIDx4dWVzaHVhaUBsaW51eC5hbGli
YWJhLmNvbT47DQo+IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+OyBBQ1BJIERl
dmVsIE1hbGluZyBMaXN0DQo+IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtl
cm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVu
IGxpc3Q6RURBQy1DT1JFDQo+IDxsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVj
dDogUmU6IOWbnuWkjTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5pdCBhaGVhZCBv
ZiBnaGVzIHBsYXRmb3JtDQo+IGRydiByZWdpc3Rlcg0KPg0KPiBPbiBUdWUsIEF1ZyAwOSwgMjAy
MiBhdCAwOToyNDozM0FNICswMDAwLCBKdXN0aW4gSGUgd3JvdGU6DQo+ID4gSWYgbm8sIHdoYXQg
aXMgdGhlIGRldGFpbCBsb2dpYyBvZiBnaGVzX2VkYWNfZHJpdmVyX2lzX3ByZWZlcnJlZCgpPw0K
Pg0KPiBUaGF0IHNob3VsZCBiZSBtb3ZlZCBmcm9tIGdoZXNfZWRhYy5jIHRvIGdoZXMuYzoNCj4N
Cj4gLyoNCj4gICogS25vd24gc3lzdGVtcyB0aGF0IGFyZSBzYWZlIHRvIGVuYWJsZSB0aGlzIG1v
ZHVsZS4NCj4gICovDQo+IHN0YXRpYyBzdHJ1Y3QgYWNwaV9wbGF0Zm9ybV9saXN0IHBsYXRfbGlz
dFtdID0gew0KPiAgICAgICAgIHsiSFBFICAgIiwgIlNlcnZlciAgIiwgMCwgQUNQSV9TSUdfRkFE
VCwgYWxsX3ZlcnNpb25zfSwNCj4gICAgICAgICB7IH0gLyogRW5kICovDQo+IH07DQo+DQo+IGFu
ZCB0aGVuDQo+DQo+IGJvb2wgZ2hlc19lZGFjX2RyaXZlcl9pc19wcmVmZXJyZWQoKQ0KPiB7DQo+
ICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19YODYpKSB7DQo+ICAgICAgICAgICAgICAgICAv
KiBDaGVjayBpZiBzYWZlIHRvIGVuYWJsZSBvbiB0aGlzIHN5c3RlbSAqLw0KPiAgICAgICAgICAg
ICAgICAgaWR4ID0gYWNwaV9tYXRjaF9wbGF0Zm9ybV9saXN0KHBsYXRfbGlzdCk7DQo+ICAgICAg
IH0gZWxzZSBpZiAoQVJNKSB7DQo+ICAgICAgICAgICAgICAgLyogaW5zZXJ0IEFSTSBsb2dpYyBo
ZXJlICovDQo+ICAgICAgIH0NCj4gfQ0KPg0KPiBUaGF0IGZ1bmN0aW9uIHNob3VsZCBiZSBjYWxs
ZWQgYnkgdGhlIEVEQUMgbW9kdWxlcyB3aGljaCBjb21wZXRlIHdpdGgNCj4gZ2hlc19lZGFjLg0K
Pg0KPiBJbiB0aGUgeDg2IGNhc2UsIHRoYXQncyBzYl9lZGFjLCBza3hfZWRhYyBhbmQgYW1kNjRf
ZWRhYywgSSBndWVzcy4NCg0KT2ssIHRoYW5rcyBhIGxvdCBmb3IgZWxhYm9yYXRpbmcgaXQgbW9y
ZS4NCkxldCBtZSBzdW1tYXJpemUgaXQgYmVmb3JlIHNlbmRpbmcgdjIgKG1heWJlIHRvbW9ycm93
KToNCjEuIGltcGxlbWVudCBhIGdoZXNfZWRhY19kcml2ZXJfaXNfcHJlZmVycmVkKCkgdG8gcmVw
bGFjZSB0aGUgb2xkIGdoZXNfZWRhY19yZWdpc3RlcigpDQphbmQgbW92ZSBpdCB0byBnaGVzLmMg
dG9nZXRoZXIgd2l0aCBwbGF0X2xpc3QNCjIuIHNhdmUgdGhlIGdoZXMgYW5kIGRldiB0byBhIGds
b2JhbCBzdHJ1Y3R1cmUgYW5kIHBhc3MgaXQgdG8gdGhlIG5ldyBtb2R1bGVfaW5pdA0KMy5tb3Zl
IHRoZSByZW1haW4gbG9naWMgb2Ygb2xkIGdoZXNfZWRhY19yZWdpc3RlcigpIHRvIGEgbmV3IFhY
X2luaXQoKSB3aGljaCBpcyB1bmRlciB0aGUNCm1vZHVsZV9pbml0IHBhdGguDQo0LiBpbnRyb2R1
Y2UgYSBzdHViIGdoZXNfZWRhY19kcml2ZXJfaXNfcHJlZmVycmVkKCkgZm9yIHNiX2VkYWMsIHNr
eF9lZGFjIGFuZCBhbWQ2NF9lZGFjDQp0byBjaGVjay4NCjUuIGFkZCB0aGUgY2hlY2sgY29uZGl0
aW9uIGluIHRoZSBYWFhfaW5pdCBvZiBzYl9lZGFjLCBza3hfZWRhYyBhbmQgYW1kNjRfZWRhYw0K
DQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBtaXNzZWQgYW55dGhpbmcgYWJvdmUuDQoNCg0KLS0N
CkNoZWVycywNCkp1c3RpbiAoSmlhIEhlKQ0KDQoNCj4NCj4gSXQgYWxsIGRlcGVuZHMgb24gd2hh
dCBwbGF0Zm9ybXMgVG9zaGkgd2FudHMgdG8gbG9hZCBpdCAtIEknbSBndWVzc2luZyBIUEUgaGFz
DQo+IGJvdGggSW50ZWwgYW5kIEFNRCBwbGF0Zm9ybXMgd2hlcmUgdGhleSBwcmVmZXIgZ2hlc19l
ZGFjLg0KPg0KPiBPbiBBUk0sIHRoYXQncyB1cCB0byBBUk0gZm9sa3MuDQo+DQo+ID4gQmVjYXVz
ZSBJIG5vdGljZSB0aGF0IGxvdHMgb2Ygb3RoZXIgZWRhYyBkcml2ZXJzIGFyZSBwcm9iaW5nIGxp
a2U6DQo+ID4gLi4uDQo+ID4gICAgICAgICBvd25lciA9IGVkYWNfZ2V0X293bmVyKCk7DQo+ID4g
ICAgICAgICBpZiAob3duZXIgJiYgc3RybmNtcChvd25lciwgRURBQ19NT0RfU1RSLA0KPiBzaXpl
b2YoRURBQ19NT0RfU1RSKSkpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+
DQo+IE5vLCB0aGF0J3MgYSBzaWxseSBtZWNoYW5pc20gdG8gYWxsb3cgYSBzaW5nbGUgRURBQyBk
cml2ZXIgdG8gbG9hZCBvbiB0aGUNCj4gc3lzdGVtLiBCdXQgeW91ciB0ZXN0IHdpbGwgZ28gYmVm
b3JlIGl0LCBhdCB0aGUgdmVyeSBiZWdpbm5pbmcgb2YgdGhlIGluaXQNCj4gZnVuY3Rpb24uDQo+
DQo+IEhUSC4NCj4NCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPg0KPiBo
dHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KSU1Q
T1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIg
aW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVy
IHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5m
b3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
