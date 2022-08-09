Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51F58D71E
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbiHIKGY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 06:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiHIKGV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 06:06:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23171FCDD;
        Tue,  9 Aug 2022 03:06:18 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=H/baZnBq1RUZ2iA6hl3bSbQpThHp+dtu2Z5DBlJc+4cnusMVF6d0YLS5UzC4UWXsOCXlmVwhDOaBTqpi4EV77HxxhfCZp7UbfGEbEqtl+VKote1PbzW9dacbel6piGqShCjQEGt8eHWCBJhy0STaUEwcNye6YxqFfRArL6KfenNZYPdndeFGP8Tj0Kp/uQVfNGlX7Mxq51gHtgQjoagnR2ZWir5km+BgvtySttt4fspzEsA+2nift0IIl7qOP8L1UURItbzQwin+5bAHw/IJkVJSqvGdF/TV8MKIcxpLT6J9tnGHy5FblDAIBHQK3HSlDjSq4dDrN2aJ4IY+vQ2weA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjNTAVweO13OxScRgdJg70IWH2aDYptXvDYzkOIWBdw=;
 b=AGfrXAWb72To+pNnDYWZ29id/Q8c1udDuU1LNaTPI745AfYnwnMZyQaBlVTRP8+WreVBjc3nb2UtcBSmooaGYhmAZlSC6loK9VUf7jBeFiBVCy/PJMni0wLnK4rmy0uaQFst/iCyuGbdc8IbVK1UDuKuVpLOhESxb3qzxjLVcEpO6N32iVGdrxbSPWpMW+FUaADIb75XG9/IjXHJxtQZPAeogdP716mc8YwN+7mCvxQp+U58toS2P/mX5I2UlKAq9n/uxMZS0D53WnZ2tntjxqgjMVR8cJitPEhgiDw/ElmYextBkc+jWYh7zR1Puzl4SQGT9jT9nhfeSagKpcL1Fg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjNTAVweO13OxScRgdJg70IWH2aDYptXvDYzkOIWBdw=;
 b=SWVAhWy9/1XusVXRFoUjuBtk0qOKTTZPxHU2Nyh/BmsNP/PGUGvDUvin4UrUiBrzTpHsJGMdlvBZms+BBPCbblqZkrFoESnI8u39Tn4bKsItcx7Vt2zjSOl84lTjMRPcUbnxFJM3xB6J9quFDToo3OqcRGMqGSN3jqWmvaH3Dpg=
Received: from DB9PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:10:1d9::11)
 by VE1PR08MB5711.eurprd08.prod.outlook.com (2603:10a6:800:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 10:06:16 +0000
Received: from DBAEUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::b5) by DB9PR02CA0006.outlook.office365.com
 (2603:10a6:10:1d9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Tue, 9 Aug 2022 10:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT059.mail.protection.outlook.com (100.127.142.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16 via Frontend Transport; Tue, 9 Aug 2022 10:06:15 +0000
Received: ("Tessian outbound fa99bf31ee7d:v123"); Tue, 09 Aug 2022 10:06:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fe71d710285b2e18
X-CR-MTA-TID: 64aa7808
Received: from dfa6ca16284a.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F63141F2-8D7F-4FA3-BC0D-6D26712F9CDD.1;
        Tue, 09 Aug 2022 10:06:06 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dfa6ca16284a.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Aug 2022 10:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3B4TPpmb5dFgGRbQmeTpoaDI5dtq0a72q1EVtr3SVgE2xXWfWnVvjQ+hugJZ+HqWr4wo3/5zQw0apr0CWVLbKPKdB7AguvH5buYoXA7aZhoDWs1NrVIYTmvU6HRPSLDdsV4uvqGxmQwPkeNpZD3mwZKYN9H+ZyDqhOGd/YApEM0c9JMJuDGjLGYBD3KrEpOT+1jZNyOVd/gKipv9HtVV5Puw86EUlKzoAWVVxPl5Yj2quzosGri38ceTQTZSCHAjGMi/eMKEnvqahNexV2H1iR6tA5B04I1Va89Da6WGzSD/voV11K5VXBQnDnGs4BYVQPpA7osZAJiQ3gmLiKrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjNTAVweO13OxScRgdJg70IWH2aDYptXvDYzkOIWBdw=;
 b=J6om9DppCrl6Ro3nUuNMxynz2+bsqyXzDHGEbM1wa0nJ2mBEC9+2QUNE/Xdr2HyJQSp7+OjMo/exSMduTt0yaFJUacPJEAlczIGzpFElKKTLQpTz763wllLgpF8MXSoQ/VzyrTAmzV2b0Fb2NejZOte0g2oqVdjDNTsX/yvhkKikRWVx+LhZbVfzAV1nNl6vZk8gF0RvAue4a7G6QQGJVggfFHq1fXmDopNg76j1aRSMo406uSFHqZhA98qiC8zcvBsNYlTqmK/JBb1UGdq39h+k06froMKFogpXkMb30dpeSsuFKJKlJ8iX6ApN/KsCj2udKCKWxg0lSFDR5x+TTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjNTAVweO13OxScRgdJg70IWH2aDYptXvDYzkOIWBdw=;
 b=SWVAhWy9/1XusVXRFoUjuBtk0qOKTTZPxHU2Nyh/BmsNP/PGUGvDUvin4UrUiBrzTpHsJGMdlvBZms+BBPCbblqZkrFoESnI8u39Tn4bKsItcx7Vt2zjSOl84lTjMRPcUbnxFJM3xB6J9quFDToo3OqcRGMqGSN3jqWmvaH3Dpg=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by VI1PR0802MB2336.eurprd08.prod.outlook.com (2603:10a6:800:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 10:06:01 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 10:06:01 +0000
From:   Justin He <Justin.He@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk6IEFQRUk6IG1vdmUgZWRhY19pbml0IGFo?=
 =?utf-8?Q?ead_of_ghes_platform_drv_register?=
Thread-Topic: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Thread-Index: AQHYqHOdT73gyPDB9Uq80vSHBXC6162lVXgAgAAFgwCAACJBAIAA37OQ
Date:   Tue, 9 Aug 2022 10:06:01 +0000
Message-ID: <DBBPR08MB4538A3F6A2F63B3AC8223FA6F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: c64db7ac-e5dc-4c88-7ee9-08da79eecc02
x-ms-traffictypediagnostic: VI1PR0802MB2336:EE_|DBAEUR03FT059:EE_|VE1PR08MB5711:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0CriUhWH4I54HLi3WrbSSYgww1/BqtYwuRImz3MvTq96g44ixbPY/fnpLJFZN41HRGuLdKjUwzi9OmmF9rVF7u8gULFfah1WVRR3ZQDAjLn0H/FTdYjyeTnL5eBQeL3+9dJW+8w5IL2D00lBUYM5RV+yU9pvvrtFWcjaPNVrXCcuWld89vasu/8WOjqwrowSehWQhVwXH9t4d2sUMygsjtinikIkix0pEY0qQ0In+DPqp/EQZTSYHmV8BlPNLehAabbb15STro6ff5PUgVIhrXjKYD19hY+/mpK7JN4NcHevmfZ8CqjAe7+W74amjonwNu3d5tHqjt6Q0KmhGtf0ttu+/r9tAbul0GpezHzxrb36HYjryeC6DR3qY2y7Y3srT37EWdasq/ADMDuPXWVWtBBLEW0fPOiLKDvAzBwXroOd0Ko+5eEAHecXltWmEmRi2ZHZQZSQ9Yl4Dc2ZzhRBUj9EGDXN5VFmLsQhlF/S1UqtdOR+H/XYTo3bTAYWyPmTIMW8KKQPlEiCgYRRYwGTaF0hEQI+Atr1JbQek9QHFfUH3PxH7unUxkVYB9cKUqrKJNW5nZQmdc8dHStLuQgNG1dprXuuveQSiI87w2LRgTjeGJDCncc7ixBAyo6aJXwio5vUBYocPGYI8EYeRwy+qx1wGAtV5UYCJ4/OHabrneqy61vee4B8p180xXx18KMWKW1FytRZpA3zpW9AdMrpT8eqLFmLEzgpbnpp1CmpG0Qfimn3/TVApPafvc7B19qgBme5xVWJCfxSv27EF9XdcZVNxFKRrY9Tco4aVcWPtUCkBOLxTB4aCeR62ktWvW47
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(478600001)(41300700001)(7696005)(6506007)(26005)(9686003)(55016003)(2906002)(7416002)(316002)(224303003)(86362001)(66556008)(33656002)(110136005)(54906003)(71200400001)(53546011)(38070700005)(186003)(66946007)(38100700002)(5660300002)(8936002)(52536014)(76116006)(66476007)(4326008)(66446008)(64756008)(83380400001)(122000001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2336
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e438f553-b9d4-479a-c32d-08da79eec359
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4H0C2kDKEu2GbRldlvegPlLxA7mune1ypMxrjSzm/gHCBrvPmy6DFsFnA9mPYUk1t+CAJzCtzsltn7LpVDgm2+YGGlEsif8mcyuzGvfZ0W3gXaFsFkp2+5xZ0rj5KfomRPB40oQ48rD78QwJH9PM1gAUQGy0YOFonghhuTY4qdVHfTVDz5dgKKPah7tNbOBnSFpRuiLDii9Yl2oQBoEPO7ZcwT/Z0yDWysw2OTT0jWjde7XgpeJXI+D0QprGR/ih8Eq5JA3XghV0HX+NaZ2l8lCiha9YUMY2fqDn+XzPZzXeJwYVkibEms2PFH3hRtAss6QnvHd1tFzF5kenzSq+kCvwJEB5aQmtcLSd6XbcB7eG2XIHXRApMIm+UpC0uu1N4Ta1xJ9xxcVRfFAd+sWp44pGrKlZ2TG1EL2z5+WqBSaUFWdJln2YMTWk65oUDKvQUkiG/zmeCc553OCzTPTmv2p3GS3EiEGjNiAiKAW8gxwGQCUU5N0kuyNlPOALhGezZH3LTQRRoF1vSxH9VNJfJKd0qbk4HpwaEUMAC22T+jR2ENQKwNgBEU5T4CnJFQKNlRaP1FJrOBnxGsWffGUSfFQsXfrUj0MeLIXTeIxVeQNhs6Zr8gJHH+lLQfSEmQ1lLBZ2Hldn+w7bJjJqrDVkfC3EqRttgYrcq0DMo0bzv/jCbYO2v+BHwOyFNkiE4nBQnVnn3S6NGQlQs80nMDYabgOzaQEvw2ZPoFup4DbRkkV69cKChnxUEqZTk48XVQ65T4RNgYN6E4BixueII0trEe1ljyrhzRm28iiDgxUpevKVF28u+CUiYIQWexUvGr3m
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(40470700004)(46966006)(55016003)(40480700001)(70206006)(52536014)(2906002)(4326008)(70586007)(33656002)(450100002)(54906003)(110136005)(478600001)(224303003)(316002)(82310400005)(81166007)(53546011)(9686003)(41300700001)(6506007)(26005)(86362001)(7696005)(36860700001)(8936002)(5660300002)(356005)(336012)(82740400003)(186003)(47076005)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 10:06:15.8083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64db7ac-e5dc-4c88-7ee9-08da79eecc02
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5711
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgS2FuaSwNCg0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogS2FuaSwg
VG9zaGkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiBUdWVzZGF5LCBBdWd1
c3QgOSwgMjAyMiA0OjQwIEFNDQo+IOaUtuS7tuS6ujogQm9yaXNsYXYgUGV0a292IDxicEBhbGll
bjguZGU+OyBSYWZhZWwgSi4gV3lzb2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IOaKhOmA
gTogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT47IExlbiBCcm93biA8bGVuYkBrZXJuZWwu
b3JnPjsgSmFtZXMNCj4gTW9yc2UgPEphbWVzLk1vcnNlQGFybS5jb20+OyBUb255IEx1Y2sgPHRv
bnkubHVja0BpbnRlbC5jb20+OyBNYXVybw0KPiBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2Vy
bmVsLm9yZz47IFJvYmVydCBSaWNodGVyIDxycmljQGtlcm5lbC5vcmc+Ow0KPiBTaHVhaSBYdWUg
PHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tPjsgSmFya2tvIFNha2tpbmVuDQo+IDxqYXJra29A
a2VybmVsLm9yZz47IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJu
ZWwub3JnPjsNCj4gTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IG9wZW4NCj4gbGlzdDpFREFDLUNPUkUgPGxpbnV4LWVkYWNAdmdlci5rZXJu
ZWwub3JnPg0KPiDkuLvpopg6IFJFOiBbUEFUQ0hdIEFDUEk6IEFQRUk6IG1vdmUgZWRhY19pbml0
IGFoZWFkIG9mIGdoZXMgcGxhdGZvcm0gZHJ2DQo+IHJlZ2lzdGVyDQo+DQo+IE9uIE1vbmRheSwg
QXVndXN0IDgsIDIwMjIgMTI6MzggUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiBPbiBN
b24sIEF1ZyAwOCwgMjAyMiBhdCAwODoxNzo1OFBNICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3
cm90ZToNCj4gPiA+IFRoaXMgZWZmZWN0aXZlbHkgbWFrZXMgRURBQyBkZXBlbmQgb24gR0hFUyB3
aGljaCBtYXkgbm90IGJlIGFsd2F5cw0KPiA+ID4gdmFsaWQgQUZBSUNTLg0KPiA+DQo+ID4gWWVz
LCBhbmQgdGhpcyBoYXMgYmVlbiBnZXR0aW5nIG9uIG15IG5lcnZlcyBzaW5jZSBmb3JldmVyLg0K
PiA+DQo+ID4gVGhlIEdIRVMgY29kZSB3aGljaCBkb2VzIGNvbGxlY3QgYWxsIHRob3NlIGVycm9y
cyAqZm9yY2VzKiB0aGUNCj4gPiByZWdpc3RyYXRpb24gb2YgYW4gRURBQyBtb2R1bGUgd2hpY2gg
ZG9lcyBvbmx5IHRoZSByZXBvcnRpbmcuDQo+ID4NCj4gPiBXaGljaCBjYW5ub3QgYmUgYW55IG1v
cmUgYmFja3dhcmRzLg0KPiA+DQo+ID4gV2hhdCBzaG91bGQgaGFwcGVuIGlzLCBHSEVTIGluaXRz
IGFuZCBzdGFydHMgd29ya2luZyBvbiB0aGUgZXJyb3JzLg0KPiA+IFRoZW4sIGF0IHNvbWUgcG9p
bnQgbGF0ZXIsIGdoZXNfZWRhYyBsb2FkcyBhbmQgc3RhcnRzIHJlcG9ydGluZw0KPiA+IHdoYXRl
dmVyIGl0IGdldHMuIElmIHRoZXJlJ3Mgbm8gRURBQyBtb2R1bGUsIGl0IGRvZXNuJ3QgcmVwb3J0
IHRoZW0uDQo+ID4gVGhlIHNhbWUgd2F5IE1DQSB3b3Jrcy4NCj4gPg0KPiA+IFRoYXQncyBpdC4N
Cj4gPg0KPiA+IEFuZCB0aGVuIGdoZXNfZWRhYyBjYW4gYmUgbWFkZSBhIG5vcm1hbCBtb2R1bGUg
YWdhaW4gYW5kIHdlIGNhbiBnZXQNCj4gPiByaWQgb2YgdGhpcyBpbnNhbml0eS4NCj4NCj4gVGhl
IGZvbGxvd2luZyBhcHByb2FjaCBtYXkgYmUgY29uc2lkZXJhYmxlOg0KPiAtIFNlcGFyYXRlIGdo
ZXNfZWRhY19yZWdpc3RlcigpIGludG8gdHdvIGZ1bmN0aW9ucywgZS5nLiwgZ2hlc19lZGFjX3Jl
Z2lzdGVyKCkNCj4gYW5kIGdoZXNfZWRhY19pbml0KCkuDQo+IC0gZ2hlc19lZGFjX3JlZ2lzdGVy
KCkgb25seSB0YWtlcyB0aGUgZmlyc3QgaWYtYmxvY2sgd2l0aCBJU19FTkFCTEVEKCkgJg0KPiBm
b3JjZV9sb2FkIGNoZWNrLCBhbmQgdGhlbiBjYWxscyBhIG5ldyBmdW5jdGlvbiwNCj4gZWRhY19z
ZXRfb3duZXIobW9kX25hbWUpLCB3aGljaCBzaW1wbHkgc2V0cyBtb2RfbmFtZSB0bw0KPiBlZGFj
X21jX293bmVyLiAgVGhpcyBhbGxvd3MgZ2hlc19lZGFjX3JlZ2lzdGVyKCkgdG8gcnVuIGJlZm9y
ZSBlZGFjX2luaXQoKSwNCj4gYW5kIHNldHMgZWRhY19tY19vd25lciB0byBwcmV2ZW50IGNoaXBz
ZXQtc3BlY2lmaWMgZWRhYyBkcml2ZXIgdG8gYmUgbG9hZGVkDQo+IGJlZm9yZSBnaGVzX2VkYWMu
DQo+IC0gZ2hlc19lZGFjX2luaXQoKSBmaXJzdCBjYWxscyBlZGFjX2dldF9vd25lcigpIHRvIG1h
dGNoIHdpdGggaXRzIG1vZF9uYW1lLg0KPiBJZiBzbywgaXQgcGVyZm9ybXMgdGhlIHJlc3Qgb2Yg
dGhlIG9yaWdpbmFsIGdoZXNfZWRhY19yZWdpc3RlcigpIHByb2NlZHVyZS4NCj4gVGhpcw0KPiBn
aGVzX2VkYWNfaW5pdCgpIGlzIGNhbGxlZCBmcm9tIHRoZSBub3JtYWwgbW9kdWxlIGluaXQgcGF0
aCwgZS5nLiwNCj4gbW9kdWxlX2luaXQoKS4NClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24sIG9u
ZSBnYXAgaXMgdGhhdCB1bmRlciBtb2R1bGVfaW5pdCBwYXRoLCBob3cgY2FuIHdlIHBhc3MNCiB0
aGUgMm5kIHBhcmFtZXRlciBvZiBnaGVzX2VkYWNfcmVnaXN0ZXIgKHN0cnVjdCBkZXZpY2UgKmRl
dikgdG8gdGhlIG5ldw0KKiBnaGVzX2VkYWNfaW5pdCgpPw0KDQpJSVVDLCB0aGUgcGFyYW1ldGVy
IG9mIGFueSBmdW5jdGlvbnMgdW5kZXIgbW9kdWxlX2luaXQoKSBwYXRoIHNob3VsZCBiZSB2b2lk
Lg0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQpJTVBPUlRBTlQgTk9USUNF
OiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25m
aWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBp
bnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBh
bmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2Ug
aXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBh
bnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
