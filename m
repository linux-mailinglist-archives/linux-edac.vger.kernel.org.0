Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8058F543
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 02:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiHKAjc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Aug 2022 20:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHKAjb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Aug 2022 20:39:31 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD1CAE21A;
        Wed, 10 Aug 2022 17:39:29 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mutS0V1KN+tORrUnww1cs42MyeAQFCbkH6EzBbDA6U4v75g///QMuIU/i1OHsnlrEHoZuDCmb3WPWttJACb2Kwwcf160+3xccy6Ri8wBt+EySWjReIuHahAzwWqCRYmwm0nMQ4cKrafVkj0AMausQUQlG/BvqniEatm90RM9zEmJRRrPnWilI3qUH10fAJWI1KYiPKspfodWS7SrcbhIXdMS0XlZat6SJQa+blIL3EkvdyqXX2SpuRTfMHBNLOHs9asy7lERX77T4A93536xK1QTfxtoVW1V78KssmAh8DF+cIpp1vsdyCc+phSGjcgM1uHNt5zUlVuiO+iG/iX6AQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3dCmvHZ6lLZDXE3FbLHcmJvGYLMH45j0sFjn1NWQSA=;
 b=L11/DQzX2Ut1V2EGRrCIPMl04h1OT6R6px62wK5WZ/M28PKUbZQn3ukv/9FCh/XX6+PK7fP7dxhFqFXjrO19ctrXcnHNB5jQUtt0zZBb7KyO62UP797yskokS97usRY48sYvH05YSCvgkwjihsvh40bphNF8ulGPbkGZdTS1Yx/kmLEZChysUbaYXu+r4E8lba/3Dy2Rq87qm3dBZGv4xnMFncaR8Oi5h48E3ph1CWNMvj+luBmzGL63DxknAclcBE2XqS5cq+M5r2a6pfYd2H7A8+5Eq5cX4Ag7kPfFBDAPcY96CLkJTZmjyuCq5VifXNF166+EmLP9jM1LWklfnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3dCmvHZ6lLZDXE3FbLHcmJvGYLMH45j0sFjn1NWQSA=;
 b=5k7GDj0o+wAL0HNoJR5qJA7WgDBEWsKXKYVcwCHhpvgMRMhIwRTJXocheKHPm8VhpGnbIGaz5X/RZKUv4mNqU5pWpqSvkeoiOi9943c7RDOUo/gIElSbvDKcE2ysZuGF1h59XS00Tv75H/q7HsUw7zU4vIgGQYrrEMD45O4UTxg=
Received: from AM6P191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::17)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 00:39:25 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::36) by AM6P191CA0040.outlook.office365.com
 (2603:10a6:209:7f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Thu, 11 Aug 2022 00:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 00:39:25 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Thu, 11 Aug 2022 00:39:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c2092f6816e1fd73
X-CR-MTA-TID: 64aa7808
Received: from 32b6e92f8899.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 03D19F0D-10A0-40FB-80F4-6174B0B37764.1;
        Thu, 11 Aug 2022 00:39:15 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 32b6e92f8899.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 11 Aug 2022 00:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOX/ysJH+LSSiNR0FM4OiYigsTqeBXpIcVjQ8AcuLKgJrg+Ta422rRQL5z0y/MZlkPuvJTItA1GMuqNgfInt1QiTPVljjxhfqJ/ZW1jUQKbqQMIObK3dAiYdW96kTFgA5EHaylGfZaBrLrCIM/t96yvinVw/7LyXjHzdf56+X6xAlTStlZjOy31SMvlFkPCIK0meAlmMEMs+Hpt9QhB0OPp2aOFKsel4Y6876V7WUsr7G2mXvGP2UFxMXmPwMil2AqV225nQO6VhStEL6aPrSUAOiG6NYDqYX4F5s2DvJBLM/QU2YfoOODkreP4RPuuK2XgZ2Uddc3KJE69sEgwOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3dCmvHZ6lLZDXE3FbLHcmJvGYLMH45j0sFjn1NWQSA=;
 b=Fw/8I/6aInq0QR4qSykEDFo3rcHrytp9CiqZPQrg64ommbTHMKIV9Ik7qjF4VakMRP+vBaZzGD7QJXB5IAa3c8J24C1eB48MBaBqHsYIITepNgpM9LfzCKKWOp8YLqPSBN9dMpSKngl3hdspx+/0UdWEVaQJ/7XtTQ5qvJ1Qv4oUilbFoMdbED52RvhXByGfWbcUNryqCXjrT7ogKgL2IIFwMY1tC/yDSj0XUdlWgqgGH2mq0Bi01zgMiL6b3lSU/dKLjesq1i4ZHCyO5uOPJbCc0DF6sLqzKHRYZX9VcbcsImcvgwcK88Vki361BcxH2LTEkTonElsuynfrK27Qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3dCmvHZ6lLZDXE3FbLHcmJvGYLMH45j0sFjn1NWQSA=;
 b=5k7GDj0o+wAL0HNoJR5qJA7WgDBEWsKXKYVcwCHhpvgMRMhIwRTJXocheKHPm8VhpGnbIGaz5X/RZKUv4mNqU5pWpqSvkeoiOi9943c7RDOUo/gIElSbvDKcE2ysZuGF1h59XS00Tv75H/q7HsUw7zU4vIgGQYrrEMD45O4UTxg=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DB7PR08MB3049.eurprd08.prod.outlook.com (2603:10a6:5:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 00:39:11 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.023; Thu, 11 Aug 2022
 00:39:11 +0000
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
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, nd <nd@arm.com>
Subject: =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5p?=
 =?utf-8?Q?t_ahead_of_ghes_platform_drv_register?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk6IEFQRUk6IG1vdmUgZWRhY19pbml0IGFo?=
 =?utf-8?Q?ead_of_ghes_platform_drv_register?=
Thread-Index: AQHYqHOdT73gyPDB9Uq80vSHBXC6162lVXgAgAAFgwCAACJBAIAABLiAgAAEGgCAAAJ0gIAABFqAgACo6oCAABqDYIAAIZGAgABbUgCAAAk8gIAAGVQAgAH0AuA=
Date:   Thu, 11 Aug 2022 00:39:10 +0000
Message-ID: <DBBPR08MB4538CB7A96F4C8CA42C29243F7649@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
 <DBBPR08MB453870FA5C5D26AADFDF05C7F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvKWP2BcAh/+YKXM@zn.tnic> <YvKrfqAsVLUqW5PN@zn.tnic>
In-Reply-To: <YvKrfqAsVLUqW5PN@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: a6a2bce2-8493-49d2-b40c-08da7b31f124
x-ms-traffictypediagnostic: DB7PR08MB3049:EE_|AM5EUR03FT058:EE_|PAVPR08MB8992:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: WN7SXc4GSIPP06nUVwN4wSbnPMNNMiD0fvsVY405+/1mFjGYzcICjUN4f+WSuL0KTzj9yKGJEqBOJIoL7cVXi/gClE56cVunoD9RiLqpUDuiOpw5hVSVh5DK0hmCvtwzkV3b5rAnKHFly5UXgYlrHWX+SJ/y7XezkycjhmEdHO/0MomzjidTuti5uax4ug5VSKcjeypRSW/iDP6iysU2xC6I1UQDvmbgl7C6f7lGzKLWjLNurKd61cEbvXf/PXKx/OmQJL2VNTJ9wfQ358HQV1eX0tD4qXIkfzu7xIHKWXFnMAHfDyloJZMzldU3uwSyv8Hv5+F1++dwI9XY6tsb5Oc+a/znuUva52kiAxwfgYfi0BKD4DtuSbcidp3MpmPmne5BZZSHUyjq77qHQPh+aRQgl1DvFKEVXaQ+SCcjGGsFsCWN/HzRXplmr9cMe9tFmBU/Rv36JxALlG0dA2Jw4yFJMCWnZ7pJG4k9OcdfcsBlfR9jrpYMO0eDQFv6nSTbIfD9bkAgLIwTkkXOyxCSADEveiObl31nAU6pAaz/criDQY2Fu7vYWhuotGCkLgEYPW8YQWS+TXtB9cWg9qCZK80uMePtA2B9npVk8eu2eYGu6sAH24Wu14k0W+S7w5Hshs1nS6TcnpKDk+h3lF45RxxJlT8IRM7PkGUzvRUGRxkcXQ48XW/1IHu7cM9F+jh6HnZafitVavWfHg9IpPAMZhHDuqhcZpoTtm7lNQc8Nz1f3tXNWvO5dv0rdT8kZRCbGiAptwjGuYzzxHW8kB578R/FeXBk64+kK3BPjLLueNaMcAOz3A0tMWyHFi2wTxLoiZ1iEA5NSzLwAhDYH27N0A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(55016003)(66946007)(52536014)(64756008)(33656002)(76116006)(66446008)(2906002)(4326008)(66476007)(66556008)(71200400001)(54906003)(478600001)(966005)(224303003)(316002)(6916009)(38100700002)(122000001)(26005)(38070700005)(41300700001)(6506007)(9686003)(86362001)(7696005)(53546011)(7416002)(8936002)(5660300002)(186003)(83380400001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZE01USs0bm9MMmlXd2pKT3N4UVZ1WlJPZm9FWWdUSzVRSFFDcEFhRDNBWFJ6?=
 =?utf-8?B?L1BwZXh2Z2ZEcU9QdE45ZUlHeWtQL0VUR0NFVStESXdlemhQaHk3cS9tT1RM?=
 =?utf-8?B?Q1FZZVNjbDVuckllY0Yxa20zd2UyVHFHNWowMnI4SFBTMVZ5Q3F1Ym0wQnZG?=
 =?utf-8?B?MWpSYnVnOHhFQlkrZFkyb0xxUGF2SUFQdlRZeEJDekZrbWwrb0ZYSTdXTmN2?=
 =?utf-8?B?MWRLMHNrNHN0M0MyZ28wWC95WUt6OTJWSHlpRmZWRHhmS09Rd3JqdnFuZ3p3?=
 =?utf-8?B?Tlp5c1ZjdlMyOVoxUmN3MmE3aXNHVG5pU1oxQjBNSUdtc0tnL0J5U1JSZ0pQ?=
 =?utf-8?B?OGd5MVp1MjB3MkRNMjlZUWZDd2pSL2lIWUJXdGQyVGU3WHhnalZWNitoelBT?=
 =?utf-8?B?NEZ4bFV6Sjd1TkxQMGVpbURhRE1wanc2dnhVUC83K0NMTEovbVlRem5HWlB0?=
 =?utf-8?B?Z2IrVFJZK3pVRXlxd1ExQ3hMSGV2OTgrbFRFT0pHdEJ0cStHVFJzbVU1ZlUx?=
 =?utf-8?B?cGt4VUhnUW13RlN5VmlReEl4WFdwRXRpMXdGcU96QXNNVm9ydFNqUC82d3F4?=
 =?utf-8?B?c01lTC92RlJGNVhUejVLOER6ZTdWMHNWa0lDbWdnZjUxbHRVbW9BMGs0UU9i?=
 =?utf-8?B?K1lGVXgwbXc5dStOL3pMSTZqVkRGeFpidTN1akp6YllqT1cwcFpuUG1GRkdQ?=
 =?utf-8?B?dGlKaStxNmZRTUp4N1hCRStmQjMxM3Y3VTF5RThMQXRKc0xSbm1TMlRoaUxJ?=
 =?utf-8?B?djNrSXB2eisrN1NINGV4OHpRRUtaaHZGcmZHRnFBSmIra280T04xaUU1RTdi?=
 =?utf-8?B?UytFbSswcTRFb0JTWWRrTE9vNE94UzR3MEFhczVJTHNjdy9zNElLT1JIaTAr?=
 =?utf-8?B?LzJRS0F1MXFITmJhNitNKzNRZUx4R3B4UWZ1SStYa3F2eWo5bVoxZzBBVWNB?=
 =?utf-8?B?akpIblA4cXBRTmI4aTREb0FHZVRSZ1IrK1pZOGUrK1pnZ3ZpNXpocDlCNWtO?=
 =?utf-8?B?V1I5M0pqMHFwamtrRmpXS3dSeEppc1dVRUJ0Q2x3SXVLazAvVnZ1YlJ6SlFw?=
 =?utf-8?B?SG4yYktPN3kwWkM4UXkyNmFDM2RwcVdwcWpaOGpuLy9yRWlTN0RENi92YTht?=
 =?utf-8?B?SzRTTU5yV2Q4SUxzbVBGZld4UGRzQTlVUWNyRi9WVENiNUZrZkR2UHYyRXdp?=
 =?utf-8?B?MkFDV3hDemNFekpOWFVpcXIzZTJENlJTa2gxdFpBdzBLV0dYRitQTTEzQktM?=
 =?utf-8?B?QVBEVWVvUWk5dkpjTlNtTDJoamRzTWZCa2hlZVJDRHZ0cERoWGdEZ1NpQi8w?=
 =?utf-8?B?b1NHZnoxa0pnTW91MkZ6SXA4UUZaWUY2NVBmaTYvQ1ZJQzNpVG9zR0dzSGdL?=
 =?utf-8?B?TnE3QytaVFg0L2NmWU96MkRpZllpSGZ6RUFibnhJT29YWnRjNXRNYVVOSmlx?=
 =?utf-8?B?a2pERWVPMzRkWjU0dU9DTnVIV01mcTIzbmtudDJGYUtTMGJJd2VuWlp6d2F3?=
 =?utf-8?B?R2doQWxIYnkxNGF3L1dkM3c5ZkNScFdJTXhnV241TzdZR1BxVmNFb3psOVI2?=
 =?utf-8?B?RjhDVk9XN0VaVkthcmJyWUxybHlhM3ZxbW1OdU1peS9wcFY0bmpQeFk2ZUJ3?=
 =?utf-8?B?NW5EMnNkbWplOXVkUWl3ZXFmbWZUbzVzQVhKa2F0OEVvdFVnSzdrTksraXFz?=
 =?utf-8?Q?fBpn1y8J7Fw2R/Q7H6Hk?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3049
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a673ccc3-6ee2-4515-5bd1-08da7b31e861
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AErHDJUKZHye6fwJUjMbCqbDtPc0nJxg/AFJ7l+wSqBoL4tGB6nP22pGWhq6PjlnEjgcTkkiLkaBjk/IWdgekeDOyFXxYEo7334KMzV9N80lqZqVVhRJxU6EY8HhJin2Yta0YJK4MjWod7lb37UKs87PyIUpbSTy4ZjU1QC/RH1g5YhGKnK8AeVd7hsd6z9DiriGo7emNuOSvfwt5ToejETDcyoai59yy9RMz8KyN6bLtlLIjFHZOiF5bCjn/ifMkGfHF7LoFkerBu1iRCqKUL0FQpfHHRGn996gUe2BwmhVFHTlljdDj3yI/5HmtJ/r1cJ0jiQaeC7g5nBriEf9FYihiXUo8m3DD/olvwrBulWGUqprITYbpJezYzzuevpAh4YgEQUkNVN1AItVt+ZdMyekpPCOBifgtZAgRwz4BOgyeEs9qy51G+dQs3b0na6IX5dttY6JBy6MmPIhyydYtgxsu1UjL9VWiZKHnw7YgglzkYcWRv8XEAgK8lhMQQcS4YzoObnLQePjBe4dh/TBJw8Jy7TbkoJI6FfctF3+O1aZTB09d2oYi9EoGyfi9dMrun/v1Cu6gTIQlz3XIIsivNw7v7ym8RMAsMlv0VVQHlVBfVxTInO022lgI0X6l9TJahNG0QaO6aKJWn6L5CSRBawac/9nTwTv4yG6CBixFpwJMXk0zNsxtacf7nb85jWsIKf1XIPXk5Xkjt4YNKuO/5KBdL2qk5uzFr4Y3UCqWOYkZ2GJIBpF161qSSTA637ZMHa29Yc8ot6YINOezEttFvEzUJx5QhjKUeckXDVeFCOXQDyzfhgf5JojvKBIJfYIPipgNYVL226sVzR6Nrcslw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(40470700004)(46966006)(36840700001)(54906003)(70206006)(224303003)(40460700003)(450100002)(55016003)(52536014)(70586007)(81166007)(86362001)(8936002)(316002)(82740400003)(5660300002)(6862004)(2906002)(36860700001)(33656002)(26005)(356005)(9686003)(966005)(7696005)(478600001)(47076005)(4326008)(40480700001)(6506007)(53546011)(83380400001)(82310400005)(41300700001)(336012)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 00:39:25.4457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a2bce2-8493-49d2-b40c-08da7b31f124
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992
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
c2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTAs
IDIwMjIgMjo0NiBBTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6
IEthbmksIFRvc2hpIDx0b3NoaS5rYW5pQGhwZS5jb20+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFm
YWVsQGtlcm5lbC5vcmc+Ow0KPiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IEphbWVzIE1v
cnNlIDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsNCj4gVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwu
Y29tPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBSb2Jl
cnQgUmljaHRlciA8cnJpY0BrZXJuZWwub3JnPjsgU2h1YWkgWHVlDQo+IDx4dWVzaHVhaUBsaW51
eC5hbGliYWJhLmNvbT47IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+OyBBQ1BJ
DQo+IERldmVsIE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IExpbnV4
IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBv
cGVuIGxpc3Q6RURBQy1DT1JFDQo+IDxsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZz4NCj4gU3Vi
amVjdDogUmU6IOWbnuWkjTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5pdCBhaGVh
ZCBvZiBnaGVzDQo+IHBsYXRmb3JtIGRydiByZWdpc3Rlcg0KPiANClsuLi5dDQo+IC0tLQ0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jIGIvZHJpdmVycy9hY3BpL2FwZWkv
Z2hlcy5jIGluZGV4DQo+IGQ5MWFkMzc4YzAwZC4uMDkxOTMxN2I4MzEzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hl
cy5jDQo+IEBAIC0xMTgsNiArMTE4LDkgQEAgbW9kdWxlX3BhcmFtX25hbWVkKGRpc2FibGUsIGdo
ZXNfZGlzYWJsZSwgYm9vbCwNCj4gMCk7ICBzdGF0aWMgTElTVF9IRUFEKGdoZXNfaGVkKTsgIHN0
YXRpYyBERUZJTkVfTVVURVgoZ2hlc19saXN0X211dGV4KTsNCj4gDQo+ICtzdGF0aWMgTElTVF9I
RUFEKGdoZXNfZGV2cyk7DQo+ICtzdGF0aWMgREVGSU5FX01VVEVYKGdoZXNfZGV2c19tdXRleCk7
DQo+ICsNCj4gIC8qDQo+ICAgKiBCZWNhdXNlIHRoZSBtZW1vcnkgYXJlYSB1c2VkIHRvIHRyYW5z
ZmVyIGhhcmR3YXJlIGVycm9yIGluZm9ybWF0aW9uDQo+ICAgKiBmcm9tIEJJT1MgdG8gTGludXgg
Y2FuIGJlIGRldGVybWluZWQgb25seSBpbiBOTUksIElSUSBvciB0aW1lciBAQA0KPiAtMTM3Niw3
ICsxMzc5LDExIEBAIHN0YXRpYyBpbnQgZ2hlc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpnaGVzX2RldikNCj4gDQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEoZ2hlc19kZXYsIGdo
ZXMpOw0KPiANCj4gLQlnaGVzX2VkYWNfcmVnaXN0ZXIoZ2hlcywgJmdoZXNfZGV2LT5kZXYpOw0K
PiArCWdoZXMtPmRldiA9ICZnaGVzX2Rldi0+ZGV2Ow0KPiArDQo+ICsJbXV0ZXhfbG9jaygmZ2hl
c19kZXZzX211dGV4KTsNCj4gKwlsaXN0X2FkZF90YWlsKCZnaGVzLT5lbGlzdCwgJmdoZXNfZGV2
cyk7DQo+ICsJbXV0ZXhfdW5sb2NrKCZnaGVzX2RldnNfbXV0ZXgpOw0KPiANCj4gIAkvKiBIYW5k
bGUgYW55IHBlbmRpbmcgZXJyb3JzIHJpZ2h0IGF3YXkgKi8NCj4gIAlzcGluX2xvY2tfaXJxc2F2
ZSgmZ2hlc19ub3RpZnlfbG9ja19pcnEsIGZsYWdzKTsgQEAgLTE0NDAsOCArMTQ0Nyw2DQo+IEBA
IHN0YXRpYyBpbnQgZ2hlc19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZ2hlc19kZXYp
DQo+IA0KPiAgCWdoZXNfZmluaShnaGVzKTsNCj4gDQo+IC0JZ2hlc19lZGFjX3VucmVnaXN0ZXIo
Z2hlcyk7DQo+IC0NCj4gIAlrZnJlZShnaGVzKTsNCj4gDQo+ICAJcGxhdGZvcm1fc2V0X2RydmRh
dGEoZ2hlc19kZXYsIE5VTEwpOw0KPiBAQCAtMTQ5NywzICsxNTAyLDI1IEBAIHZvaWQgX19pbml0
IGFjcGlfZ2hlc19pbml0KHZvaWQpDQo+ICAJZWxzZQ0KPiAgCQlwcl9pbmZvKEdIRVNfUEZYICJG
YWlsZWQgdG8gZW5hYmxlIEFQRUkgZmlybXdhcmUgZmlyc3QNCj4gbW9kZS5cbiIpOyAgfQ0KPiAr
DQo+ICsvKg0KPiArICogS25vd24geDg2IHN5c3RlbXMgdGhhdCBwcmVmZXIgR0hFUyBlcnJvciBy
ZXBvcnRpbmc6DQo+ICsgKi8NCj4gK3N0YXRpYyBzdHJ1Y3QgYWNwaV9wbGF0Zm9ybV9saXN0IHBs
YXRfbGlzdFtdID0gew0KPiArCXsiSFBFICAgIiwgIlNlcnZlciAgIiwgMCwgQUNQSV9TSUdfRkFE
VCwgYWxsX3ZlcnNpb25zfSwNCj4gKwl7IH0gLyogRW5kICovDQo+ICt9Ow0KPiArDQo+ICtzdHJ1
Y3QgbGlzdF9oZWFkICpnaGVzX2dldF9kZXZpY2VzKGJvb2wgZm9yY2UpIHsNCj4gKwlpbnQgaWR4
ID0gLTE7DQo+ICsNCj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2KSkgew0KPiArCQlpZHgg
PSBhY3BpX21hdGNoX3BsYXRmb3JtX2xpc3QocGxhdF9saXN0KTsNCj4gKwkJaWYgKGlkeCA8IDAg
JiYgIWZvcmNlKQ0KPiArCQkJcmV0dXJuIE5VTEw7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuICZn
aGVzX2RldnM7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChnaGVzX2dldF9kZXZpY2VzKTsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9LY29uZmlnIGIvZHJpdmVycy9lZGFjL0tjb25m
aWcgaW5kZXgNCj4gMTc1NjJjZjFmZTk3Li5kZjQ1ZGI4MTg1OGIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZWRhYy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+IEBAIC01
Myw4ICs1Myw4IEBAIGNvbmZpZyBFREFDX0RFQ09ERV9NQ0UNCj4gIAkgIGhhcyBiZWVuIGluaXRp
YWxpemVkLg0KPiANCj4gIGNvbmZpZyBFREFDX0dIRVMNCj4gLQlib29sICJPdXRwdXQgQUNQSSBB
UEVJL0dIRVMgQklPUyBkZXRlY3RlZCBlcnJvcnMgdmlhIEVEQUMiDQo+IC0JZGVwZW5kcyBvbiBB
Q1BJX0FQRUlfR0hFUyAmJiAoRURBQz15KQ0KPiArCXRyaXN0YXRlICJPdXRwdXQgQUNQSSBBUEVJ
L0dIRVMgQklPUyBkZXRlY3RlZCBlcnJvcnMgdmlhIEVEQUMiDQo+ICsJZGVwZW5kcyBvbiBBQ1BJ
X0FQRUlfR0hFUw0KPiAgCXNlbGVjdCBVRUZJX0NQRVINCj4gIAloZWxwDQo+ICAJICBOb3QgYWxs
IG1hY2hpbmVzIHN1cHBvcnQgaGFyZHdhcmUtZHJpdmVuIGVycm9yIHJlcG9ydC4gU29tZSBvZiB0
aG9zZQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIGIvZHJpdmVycy9l
ZGFjL2doZXNfZWRhYy5jIGluZGV4DQo+IGM4ZmE3ZGNmZGJkMC4uZGE2ZDFhOWUxMDdkIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCj4gKysrIGIvZHJpdmVycy9lZGFj
L2doZXNfZWRhYy5jDQo+IEBAIC01OSw2ICs1OSw4IEBAIG1vZHVsZV9wYXJhbShmb3JjZV9sb2Fk
LCBib29sLCAwKTsNCj4gDQo+ICBzdGF0aWMgYm9vbCBzeXN0ZW1fc2Nhbm5lZDsNCj4gDQo+ICtz
dGF0aWMgc3RydWN0IGxpc3RfaGVhZCAqZ2hlc19kZXZzOw0KPiArDQo+ICAvKiBNZW1vcnkgRGV2
aWNlIC0gVHlwZSAxNyBvZiBTTUJJT1Mgc3BlYyAqLyAgc3RydWN0IG1lbWRldl9kbWlfZW50cnkN
Cj4gew0KPiAgCXU4IHR5cGU7DQo+IEBAIC0zNzYsMzQgKzM3OCwxNSBAQCB2b2lkIGdoZXNfZWRh
Y19yZXBvcnRfbWVtX2Vycm9yKGludCBzZXYsIHN0cnVjdA0KPiBjcGVyX3NlY19tZW1fZXJyICpt
ZW1fZXJyKQ0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmdoZXNfbG9jaywgZmxhZ3MpOyAg
fQ0KPiANCj4gLS8qDQo+IC0gKiBLbm93biBzeXN0ZW1zIHRoYXQgYXJlIHNhZmUgdG8gZW5hYmxl
IHRoaXMgbW9kdWxlLg0KPiAtICovDQo+IC1zdGF0aWMgc3RydWN0IGFjcGlfcGxhdGZvcm1fbGlz
dCBwbGF0X2xpc3RbXSA9IHsNCj4gLQl7IkhQRSAgICIsICJTZXJ2ZXIgICIsIDAsIEFDUElfU0lH
X0ZBRFQsIGFsbF92ZXJzaW9uc30sDQo+IC0JeyB9IC8qIEVuZCAqLw0KPiAtfTsNCj4gLQ0KPiAt
aW50IGdoZXNfZWRhY19yZWdpc3RlcihzdHJ1Y3QgZ2hlcyAqZ2hlcywgc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiArc3RhdGljIGludCBnaGVzX2VkYWNfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiAgew0KPiAgCWJvb2wgZmFrZSA9IGZhbHNlOw0KPiAgCXN0cnVjdCBtZW1fY3RsX2luZm8g
Km1jaTsNCj4gIAlzdHJ1Y3QgZ2hlc19wdnQgKnB2dDsNCj4gIAlzdHJ1Y3QgZWRhY19tY19sYXll
ciBsYXllcnNbMV07DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gLQlpbnQgaWR4ID0gLTE7
DQo+ICAJaW50IHJjID0gMDsNCj4gDQo+IC0JaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4NikpIHsN
Cj4gLQkJLyogQ2hlY2sgaWYgc2FmZSB0byBlbmFibGUgb24gdGhpcyBzeXN0ZW0gKi8NCj4gLQkJ
aWR4ID0gYWNwaV9tYXRjaF9wbGF0Zm9ybV9saXN0KHBsYXRfbGlzdCk7DQo+IC0JCWlmICghZm9y
Y2VfbG9hZCAmJiBpZHggPCAwKQ0KPiAtCQkJcmV0dXJuIC1FTk9ERVY7DQo+IC0JfSBlbHNlIHsN
Cj4gLQkJZm9yY2VfbG9hZCA9IHRydWU7DQo+IC0JCWlkeCA9IDA7DQo+IC0JfQ0KPiAtDQo+ICAJ
LyogZmluaXNoIGFub3RoZXIgcmVnaXN0cmF0aW9uL3VucmVnaXN0cmF0aW9uIGluc3RhbmNlIGZp
cnN0ICovDQo+ICAJbXV0ZXhfbG9jaygmZ2hlc19yZWdfbXV0ZXgpOw0KPiANCj4gQEAgLTQ0Nyw3
ICs0MzAsNyBAQCBpbnQgZ2hlc19lZGFjX3JlZ2lzdGVyKHN0cnVjdCBnaGVzICpnaGVzLCBzdHJ1
Y3QNCj4gZGV2aWNlICpkZXYpDQo+ICAJCXByX2luZm8oIlRoaXMgc3lzdGVtIGhhcyBhIHZlcnkg
Y3JhcHB5IEJJT1M6IEl0IGRvZXNuJ3QgZXZlbiBsaXN0IHRoZQ0KPiBESU1NUy5cbiIpOw0KPiAg
CQlwcl9pbmZvKCJJdHMgU01CSU9TIGluZm8gaXMgd3JvbmcuIEl0IGlzIGRvdWJ0ZnVsIHRoYXQg
dGhlIGVycm9yIHJlcG9ydA0KPiB3b3VsZFxuIik7DQo+ICAJCXByX2luZm8oIndvcmsgb24gc3Vj
aCBzeXN0ZW0uIFVzZSB0aGlzIGRyaXZlciB3aXRoIGNhdXRpb25cbiIpOw0KPiAtCX0gZWxzZSBp
ZiAoaWR4IDwgMCkgew0KPiArCX0gZWxzZSBpZiAoZm9yY2VfbG9hZCkgew0KPiAgCQlwcl9pbmZv
KCJUaGlzIEVEQUMgZHJpdmVyIHJlbGllcyBvbiBCSU9TIHRvIGVudW1lcmF0ZSBtZW1vcnkgYW5k
DQo+IGdldCBlcnJvciByZXBvcnRzLlxuIik7DQo+ICAJCXByX2luZm8oIlVuZm9ydHVuYXRlbHks
IG5vdCBhbGwgQklPU2VzIHJlZmxlY3QgdGhlIG1lbW9yeSBsYXlvdXQNCj4gY29ycmVjdGx5Llxu
Iik7DQo+ICAJCXByX2luZm8oIlNvLCB0aGUgZW5kIHJlc3VsdCBvZiB1c2luZyB0aGlzIGRyaXZl
ciB2YXJpZXMgZnJvbSB2ZW5kb3IgdG8NCj4gdmVuZG9yLlxuIik7IEBAIC01MTcsNyArNTAwLDcg
QEAgaW50IGdoZXNfZWRhY19yZWdpc3RlcihzdHJ1Y3QgZ2hlcyAqZ2hlcywNCj4gc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiAgCXJldHVybiByYzsNCj4gIH0NCj4gDQo+IC12b2lkIGdoZXNfZWRhY191
bnJlZ2lzdGVyKHN0cnVjdCBnaGVzICpnaGVzKQ0KPiArc3RhdGljIHZvaWQgZ2hlc19lZGFjX3Vu
cmVnaXN0ZXIoc3RydWN0IGdoZXMgKmdoZXMpDQo+ICB7DQo+ICAJc3RydWN0IG1lbV9jdGxfaW5m
byAqbWNpOw0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IEBAIC01NTEsMyArNTM0LDMwIEBA
IHZvaWQgZ2hlc19lZGFjX3VucmVnaXN0ZXIoc3RydWN0IGdoZXMgKmdoZXMpDQo+ICB1bmxvY2s6
DQo+ICAJbXV0ZXhfdW5sb2NrKCZnaGVzX3JlZ19tdXRleCk7DQo+ICB9DQo+ICsNCj4gK3N0YXRp
YyBpbnQgX19pbml0IGdoZXNfZWRhY19pbml0KHZvaWQpDQo+ICt7DQo+ICsJc3RydWN0IGdoZXMg
KmcsICpnX3RtcDsNCj4gKw0KPiArCWdoZXNfZGV2cyA9IGdoZXNfZ2V0X2RldmljZXMoZm9yY2Vf
bG9hZCk7DQo+ICsJaWYgKGdoZXNfZGV2cykNClNob3VsZCBpdCBiZSBjaGFuZ2VkIHRvIGlmKCFn
aGVzX2RldnMpID8NCk90aGVyd2lzZSwgdGhpcyBnaGVzX2VkYWNfaW5pdCgpIG9uIEFybSB3aWxs
IGFsd2F5cyByZXR1cm4gd2l0aCBFTk9ERVYNCmJlY2F1c2UgISBnaGVzX2dldF9kZXZpY2VzKCku
DQoNCldoYXQgZG8geW91IHRoaW5rIG9mIGl0Pw0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEg
SGUpDQoNCg0KPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gKw0KPiArCWxpc3RfZm9yX2VhY2hfZW50
cnlfc2FmZShnLCBnX3RtcCwgZ2hlc19kZXZzLCBlbGlzdCkgew0KPiArCQlnaGVzX2VkYWNfcmVn
aXN0ZXIoZy0+ZGV2KTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gK21vZHVs
ZV9pbml0KGdoZXNfZWRhY19pbml0KTsNCj4gKw0KPiArc3RhdGljIHZvaWQgX19leGl0IGdoZXNf
ZWRhY19leGl0KHZvaWQpIHsNCj4gKwlzdHJ1Y3QgZ2hlcyAqZywgKmdfdG1wOw0KPiArDQo+ICsN
Cj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZywgZ190bXAsIGdoZXNfZGV2cywgZWxpc3Qp
IHsNCj4gKwkJZ2hlc19lZGFjX3VucmVnaXN0ZXIoZyk7DQo+ICsJfQ0KPiArfQ0KPiArbW9kdWxl
X2V4aXQoZ2hlc19lZGFjX2V4aXQpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL2doZXMu
aCBiL2luY2x1ZGUvYWNwaS9naGVzLmggaW5kZXgNCj4gMzRmYjM0MzFhOGYzLi5mMzliNzVjM2Y5
YzYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvYWNwaS9naGVzLmgNCj4gKysrIGIvaW5jbHVkZS9h
Y3BpL2doZXMuaA0KPiBAQCAtMjcsNiArMjcsOCBAQCBzdHJ1Y3QgZ2hlcyB7DQo+ICAJCXN0cnVj
dCB0aW1lcl9saXN0IHRpbWVyOw0KPiAgCQl1bnNpZ25lZCBpbnQgaXJxOw0KPiAgCX07DQo+ICsJ
c3RydWN0IGRldmljZSAqZGV2Ow0KPiArCXN0cnVjdCBsaXN0X2hlYWQgZWxpc3Q7DQo+ICB9Ow0K
PiANCj4gIHN0cnVjdCBnaGVzX2VzdGF0dXNfbm9kZSB7DQo+IEBAIC02OSwzNSArNzEsMTMgQEAg
aW50IGdoZXNfcmVnaXN0ZXJfdmVuZG9yX3JlY29yZF9ub3RpZmllcihzdHJ1Y3QNCj4gbm90aWZp
ZXJfYmxvY2sgKm5iKTsNCj4gICAqIEBuYjogcG9pbnRlciB0byB0aGUgbm90aWZpZXJfYmxvY2sg
c3RydWN0dXJlIG9mIHRoZSB2ZW5kb3IgcmVjb3JkIGhhbmRsZXIuDQo+ICAgKi8NCj4gIHZvaWQg
Z2hlc191bnJlZ2lzdGVyX3ZlbmRvcl9yZWNvcmRfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Js
b2NrICpuYik7DQo+ICtzdHJ1Y3QgbGlzdF9oZWFkICpnaGVzX2dldF9kZXZpY2VzKGJvb2wgZm9y
Y2UpOyAjZWxzZSBzdGF0aWMgaW5saW5lDQo+ICtzdHJ1Y3QgbGlzdF9oZWFkICpnaGVzX2dldF9k
ZXZpY2VzKGJvb2wgZm9yY2UpIHsgcmV0dXJuIE5VTEw7IH0NCj4gICNlbmRpZg0KPiANCj4gIGlu
dCBnaGVzX2VzdGF0dXNfcG9vbF9pbml0KGludCBudW1fZ2hlcyk7DQo+IA0KPiAtLyogRnJvbSBk
cml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMgKi8NCj4gLQ0KPiAtI2lmZGVmIENPTkZJR19FREFDX0dI
RVMNCj4gLXZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNw
ZXJfc2VjX21lbV9lcnINCj4gKm1lbV9lcnIpOw0KPiAtDQo+IC1pbnQgZ2hlc19lZGFjX3JlZ2lz
dGVyKHN0cnVjdCBnaGVzICpnaGVzLCBzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAtDQo+IC12b2lk
IGdoZXNfZWRhY191bnJlZ2lzdGVyKHN0cnVjdCBnaGVzICpnaGVzKTsNCj4gLQ0KPiAtI2Vsc2UN
Cj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2
LA0KPiAtCQkJCSAgICAgICBzdHJ1Y3QgY3Blcl9zZWNfbWVtX2VyciAqbWVtX2VycikNCj4gLXsN
Cj4gLX0NCj4gLQ0KPiAtc3RhdGljIGlubGluZSBpbnQgZ2hlc19lZGFjX3JlZ2lzdGVyKHN0cnVj
dCBnaGVzICpnaGVzLCBzdHJ1Y3QgZGV2aWNlICpkZXYpIC17DQo+IC0JcmV0dXJuIC1FTk9ERVY7
DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBnaGVzX2VkYWNfdW5yZWdpc3Rlcihz
dHJ1Y3QgZ2hlcyAqZ2hlcykgLXsgLX0gLSNlbmRpZg0KPiAtDQo+ICBzdGF0aWMgaW5saW5lIGlu
dCBhY3BpX2hlc3RfZ2V0X3ZlcnNpb24oc3RydWN0IGFjcGlfaGVzdF9nZW5lcmljX2RhdGEgKmdk
YXRhKQ0KPiB7DQo+ICAJcmV0dXJuIGdkYXRhLT5yZXZpc2lvbiA+PiA4Ow0KPiANCj4gLS0NCj4g
UmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVs
Lm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg==
