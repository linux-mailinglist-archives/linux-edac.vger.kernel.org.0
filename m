Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3058D672
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 11:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiHIJY5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 05:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiHIJY4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 05:24:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C41C130;
        Tue,  9 Aug 2022 02:24:54 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=m9eZXw0x5H4OQkrWwluG4yhWTiaKhnTwyA9uc5iJp4INsGphva7qN2bNjSfrAF+d9K3dfpK4UxVjfO/35s5xv4DYMCtx7qT7hou5FiTkML7fjck3TBunTCXMA8D4+gti6vJdNmdEGyMNZY8S/AJIMpmeX7NGNnITAneUypP9AK3JRToXf2r83eJYuRL/9RKrzuCeCbntKMji6y5z6P0slecXNwJFuceMV/mYk4pGi33ndmsDTui1OJAZbix9YI0dnUOBL2u6JzDdfTe/5vi/h7lnfkCDEe7JiQMqSYmy3doBkkMjXSDkgEjgYbwB5hey+jgerb8YI1gtYRsqdZw7AQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a54JQj/Ds6Dz7deh6I4E5OrDDpSAbOtelg4djtYVmsQ=;
 b=Ckpbl4eT+TVGyLzUHpH/NxKyLRmzDenRpSUsJjD/mNPiMg0m9rSSz118tssCpfENuQeFWhw9rxlQSEBO79LWDNOiDjTr92kmcmaVjkAwdRTFB3a7ENjjmGO/stjseskLN+tKiCDUEt4OG9pYRNNR08b/hEv6l855+IMtdFRNYmlKRqtZNB1mspfJP4bYWxz8IohYKCAPiGTmcDcSgDe/1+n1qxbElUMGtKYRcBcVpc1BjPNCC8JCTnkKASA6TbZ0xw1f1NGNldvLE+Ua+CFFibeR0irVjs2I7QAo90UM1v1prCdFXXt4bXybm5qX6VBt508XNsAGXed/t5Gf3Ajm1A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a54JQj/Ds6Dz7deh6I4E5OrDDpSAbOtelg4djtYVmsQ=;
 b=MaQXVJSqj0UEgqFlK8hdzdD9QtNQW0otB3fKCNhFh7LdqBF3mSumwy9wcwioeYirtwFIuzSNJZ83uEQ0JOpqOji4959moJf+TqFI27iMpQpEyVbKbmMMeX+RjBVuUH8cpVa2OKTkTqRZv0JNojq3Ml83R+goxL3iHA19ZpzjMlc=
Received: from AS9PR06CA0222.eurprd06.prod.outlook.com (2603:10a6:20b:45e::32)
 by AS8PR08MB6533.eurprd08.prod.outlook.com (2603:10a6:20b:33e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 09:24:50 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::f4) by AS9PR06CA0222.outlook.office365.com
 (2603:10a6:20b:45e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 09:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16 via Frontend Transport; Tue, 9 Aug 2022 09:24:50 +0000
Received: ("Tessian outbound 2af316122c7a:v123"); Tue, 09 Aug 2022 09:24:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 21ae22a5be715188
X-CR-MTA-TID: 64aa7808
Received: from 8a4ed2015351.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CD7763E4-512F-475E-9B40-FCDB9C9E4887.1;
        Tue, 09 Aug 2022 09:24:36 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8a4ed2015351.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Aug 2022 09:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQchNWfaWlbbRCvAJz1OjqxNgr2AA/pwtS82W5Ja14Vtm8QrwvcX5UJVEiUvcb1BPr1zPzWmISjf9+pwGubO6qn+JR3CyDn5pyWLz3Mgd3gQycd+BfPsZhUOUTXi2jil8HQm8YPWF3wlarqyV/VJq/0JVAi99FDIrsQdy6zv5+/MKAOqG5qr6T05J9EIRYrJeUmAktEl3dwEBtJmf4qPygEdiJV9BIl86Q2JV+ucvnYMVRgvbWw0PzoSD8ycIuUuQrARMLVahL6kWzrkqO+I4yH5Xj/oEahmc6sqAPvdzrU0anRYVChpt7hu5sY9XBDj6p8ZflVyen5AlCUfZvI4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a54JQj/Ds6Dz7deh6I4E5OrDDpSAbOtelg4djtYVmsQ=;
 b=PFpy5/kXcfGfj7J8Gigq/l1I5a+ChjMstgb42H4t27jfLl4kUHzdjqxYu2T1jztuqx9hNwXaFunWYnwESVJCZUniZkrdXUNn5p2ehqpFwDSGkGmmKKHltM2Rk8AcEu/T6QzdEtCyKXmuvhHb3KD/wEEFXitQ9zUs640Vf9Aa+mdDupiyDNo18QY3M5AnW2nOYZBYhQoSsy2NpQRks3RJQvOPMmr4ZTu4XGozmz/yx7tYW1cWbg12tJIecQBBnAjn/U7JX9e0hDPjzVYvDjbsCOUrU34MZrW4QuTym4LeEbW8OjneHbAtvTGi0CCV9mCljjnR6T4TIdv6/vJ7Snv0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a54JQj/Ds6Dz7deh6I4E5OrDDpSAbOtelg4djtYVmsQ=;
 b=MaQXVJSqj0UEgqFlK8hdzdD9QtNQW0otB3fKCNhFh7LdqBF3mSumwy9wcwioeYirtwFIuzSNJZ83uEQ0JOpqOji4959moJf+TqFI27iMpQpEyVbKbmMMeX+RjBVuUH8cpVa2OKTkTqRZv0JNojq3Ml83R+goxL3iHA19ZpzjMlc=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PR3PR08MB5657.eurprd08.prod.outlook.com (2603:10a6:102:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 09:24:33 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 09:24:33 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>, "Kani, Toshi" <toshi.kani@hpe.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
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
Thread-Index: AQHYqHOdT73gyPDB9Uq80vSHBXC6162lVXgAgAAFgwCAACJBAIAABLiAgAAEGgCAAAJ0gIAABFqAgACo6oCAABqDYA==
Date:   Tue, 9 Aug 2022 09:24:33 +0000
Message-ID: <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
In-Reply-To: <YvIPf/m3hU46S9Ik@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 7820de04-0832-4bf4-7790-08da79e902aa
x-ms-traffictypediagnostic: PR3PR08MB5657:EE_|AM5EUR03FT049:EE_|AS8PR08MB6533:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bdWnkYCXPjLSyixXfzsS/4EFw5xo1aR0g4I+p9qSyzR/fNZGm+wsfVMEQ3BCU0RjmiGcwlIJYSJuhOiYUSyYtmYHnDRpAk58PAKhpwubvf3PQf7sBayuaqFvqjF4J2G6ZKVJCxrSYchuVKpUL0O8fvwDeo+xzfTZ/1i5IWflYHJ1vsS78Xm4zjfrN8Tkkrld4DqJWhxp0KRBiRIhv6lLW1yqd9YXi2YFFdhiwX1S3lC1jM4+S8MhNnL9iGMSJX8PJafwF7XqXIQTEuwHH2EsvGveoeDeJQJvDZHDhKw+3hQwNRGNMZz/711rrpx6ygm/dwbArbIQcuOyUiN8lH9Hhdm2J1RAKL+R2JpaESJDL1Hyd1W/iclhwInSjHUAySpamng7994nzuzxPdWcfux6BJRoPWmN9bYoSOvbm1ilmZKJ5M+bEf/gRjxrRlfC8lIeZe4346PEm4b/ZsOjtoB09nENNBhWvc8uU3uzO7bl3Ze0H+8AnwBGOeCy9H2NATGr0odsjBjlX2xXVX8manPKzRRvxriWILMVVTBT7S/kWD2LxqdgrtzXqOgbvCWEwlWcQFsCaLQwYU+c/dVJRRTeZMC4MxDW1zC8s+cBak+b+o8wQAHMlRl8jQoaDb35vGkVu4sFrJVjDU5tmMmbhhcgsw3BKfCFse479f7yuEvCV8Qptt+8tTE5XRG2ghbGVjq+C0I6cWlYrdPWYBQYEFjTy8Bz7IabKd0DTxOdJWrST0dhcaNXhzfC3CZIt3yj4ROAM+fuQ/anie1Q706oY37FbIaUZrcxClQI5LJwHxox5UY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(41300700001)(86362001)(7696005)(26005)(6506007)(122000001)(9686003)(38100700002)(38070700005)(186003)(83380400001)(8936002)(7416002)(5660300002)(66476007)(4326008)(66946007)(76116006)(66556008)(33656002)(64756008)(66446008)(2906002)(55016003)(316002)(224303003)(71200400001)(54906003)(110136005)(52536014)(478600001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5657
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 08131fe5-9599-49e0-0e41-08da79e8f8a4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2dQEs4p6GzcMQizaYhm95yPA1LESYKSyFI+ZkIpQHVrX07+HnLmb/m66BmH8lubQrtz2/XqY4JyHpTDJG6x1u11ghCs5KHPY7YLLgr7MU1+bl9PpTvL1K3VGsIwk/Ejr7sWfbF/RV5yUPzPwFNtafs3cdfGaTod3he0p84hE5fUBOljPimkf4mBLS+6tTSUGChFtCWdUqDUVNf3l0VH4msHu+/Uhs4PXz1lqnSNDvZ5wAdV0WHu+q0GHa9JRWtMz6Rb9O6ShvrcEZDQolvTuU2p4RQ5QEeBdJdVT1saplZ/z2LsBnAZVMuY78GCST6yyLOBYsCPdaF3PnPx/Ph8fFah6k/zlzCWTzsxq1Q/j6khKgQSjKFjV2Zk46s5SxJL6NhJVqbzSIhhwSA0lB6bPmOEv0Mbg+Te3Nvyq5FvLDWQ4M3d962UbBeJ8Iq0m+1HpqHxk8E89ycyn0ke5ITXSBVmPvSsc5Iy1AaAr92F3ZH+Jqshv4SWBmwtEJBKo5jEsYzGoFfPP+4j/jrYMCZjn72I0HtSn5xK+UQXm4Y1yqN4DHtFJ8GkbzgZdxLCObdfqXSRZ4kCu9BDnj7vafGZt1crTihIueiZ81/neJfiXpeJrosb10nQq5dGyfM6b7LQtIaxjWo9zU4gcn7wEc+uyixLXGNt1/GJRDKk0YfNOE8SNLuXOYPL7/JMajBJwnVn2+2tQ2aMLBHuIlLKouCY3JZId6PXfNwJD8ILVLKar1pmHJMDoynp+8nmWMRkPw5nSffsAD9n+7XbssGuqUiQrGj9cfp+yaTVckVCd0zhI7CZ4pqXb7S5WqB/1QRM7k5Y
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(40470700004)(36840700001)(336012)(47076005)(82740400003)(356005)(81166007)(186003)(40460700003)(83380400001)(36860700001)(8936002)(5660300002)(52536014)(70586007)(4326008)(450100002)(70206006)(82310400005)(40480700001)(55016003)(2906002)(41300700001)(478600001)(26005)(9686003)(7696005)(6506007)(54906003)(110136005)(224303003)(316002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 09:24:50.4450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7820de04-0832-4bf4-7790-08da79e902aa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6533
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEJvcmlzbGF2IFBldGtv
diA8YnBAYWxpZW44LmRlPg0KPiDlj5HpgIHml7bpl7Q6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIy
IDM6NDEgUE0NCj4g5pS25Lu25Lq6OiBLYW5pLCBUb3NoaSA8dG9zaGkua2FuaUBocGUuY29tPg0K
PiDmioTpgIE6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IEp1c3RpbiBI
ZQ0KPiA8SnVzdGluLkhlQGFybS5jb20+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IEph
bWVzIE1vcnNlDQo+IDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsgVG9ueSBMdWNrIDx0b255Lmx1Y2tA
aW50ZWwuY29tPjsgTWF1cm8NCj4gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+
OyBSb2JlcnQgUmljaHRlciA8cnJpY0BrZXJuZWwub3JnPjsNCj4gU2h1YWkgWHVlIDx4dWVzaHVh
aUBsaW51eC5hbGliYWJhLmNvbT47IEphcmtrbyBTYWtraW5lbg0KPiA8amFya2tvQGtlcm5lbC5v
cmc+OyBBQ1BJIERldmVsIE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47
DQo+IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBvcGVuDQo+IGxpc3Q6RURBQy1DT1JFIDxsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZz4N
Cj4g5Li76aKYOiBSZTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5pdCBhaGVhZCBv
ZiBnaGVzIHBsYXRmb3JtIGRydg0KPiByZWdpc3Rlcg0KPg0KPiBPbiBNb24sIEF1ZyAwOCwgMjAy
MiBhdCAwOTozNjoxM1BNICswMDAwLCBLYW5pLCBUb3NoaSB3cm90ZToNCj4gPiBQbGF0Zm9ybXMg
d2l0aCBBQ1BJIEdIRVMgc3VwcG9ydCBzaG91bGQgdXNlIGdoZXNfZWRhYy4gVGhpcyBpcyB0aGUN
Cj4gPiBjYXNlIG9uIEFybS4gVGhlIHg4NiBzaWRlIGhhcyBhZGRpdGlvbmFsIHBsYXRmb3JtIElE
IGNoZWNrIHRvIHByb3RlY3QNCj4gPiBmcm9tIGxlZ2FjeSBidWdneSBHSEVTIEZXIGV4aXN0ZWQg
YmVmb3JlIGdoZXNfZWRhYyBlbmFibGVtZW50Lg0KPg0KPiBTb3VuZHMgdG8gbWUgbGlrZSB3ZSBz
aG91bGQgcHV0IGFsbCB0aGF0IGxvZ2ljIGluIGdoZXMuYyBhbmQgb3V0IG9mIGdoZXNfZWRhYw0K
PiBhbmQgdGhlIEVEQUMgZHJpdmVycyB3aWxsIHF1ZXJ5IGl0IGJ5IGRvaW5nIHVwb24gbG9hZDoN
Cj4NCj4gPGVkYWNfZHJpdmVyPl9pbml0Og0KPg0KPiAgICAgICBpZiAoZ2hlc19lZGFjX2RyaXZl
cl9pc19wcmVmZXJyZWQoKSkNCj4gICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4NCkRv
IHlvdSBtZWFuIHRoZSBzaW1pbGFyIGxvZ2ljIGFzIHdoYXQgS2FuaSBUb3NoaSBzdWdnZXN0ZWQ/
DQplLmcuDQpib29sIGdoZXNfZWRhY19kcml2ZXJfaXNfcHJlZmVycmVkKCkNCnsNCiAgICAgICAg
SWYgKG1vZF9uYW1lIGlzICJnaGVzX2VkYWMiKQ0KICAgICAgICAgICAgICAgIHJldHVybiB0cnVl
Ow0KDQogICAgICAgIHJldHVybiBmYWxzZTsNCn0NCklmIG5vLCB3aGF0IGlzIHRoZSBkZXRhaWwg
bG9naWMgb2YgZ2hlc19lZGFjX2RyaXZlcl9pc19wcmVmZXJyZWQoKT8NClRoYW5rcyBmb3IgdGhl
IGNsYXJpZmljYXRpb24g8J+Yig0KQmVjYXVzZSBJIG5vdGljZSB0aGF0IGxvdHMgb2Ygb3RoZXIg
ZWRhYyBkcml2ZXJzIGFyZSBwcm9iaW5nIGxpa2U6DQouLi4NCiAgICAgICAgb3duZXIgPSBlZGFj
X2dldF9vd25lcigpOw0KICAgICAgICBpZiAob3duZXIgJiYgc3RybmNtcChvd25lciwgRURBQ19N
T0RfU1RSLCBzaXplb2YoRURBQ19NT0RfU1RSKSkpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1F
QlVTWTsNCi4uLg0KDQo+IEFuZCB0aGVuIGdoZXNfZWRhYyBjYW4gYmVjb21lIGEgbm9ybWFsIGRy
aXZlciBtb2R1bGUgYWdhaW4uDQo+DQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCklN
UE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhl
ciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGlu
Zm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
