Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD758E915
	for <lists+linux-edac@lfdr.de>; Wed, 10 Aug 2022 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiHJIxe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Aug 2022 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiHJIxd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Aug 2022 04:53:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150044.outbound.protection.outlook.com [40.107.15.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9258C6DFB5;
        Wed, 10 Aug 2022 01:53:32 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=D+p3GvrZzEMXLcdtDBv77JNjY/bpOz1zoDf9bqkRskRuQcyzUhYRezEZ+9+D/hw7+1Ib7kUy4r5Xven+HhC7zPsfWHvP7pYeJVzT23XUN2d7/XUkP5toVj6WS5Wmt+Ucd0bFs2gFfTsbQfs/SolmIZrRI7pNz1jLJhmFichNwjTZ4mmZCnm7oxLan+qB1LEHFj0x+KhRoRcqcIKSFv1ykwyT9BNlHojlFa+XawDdbX8pOaFxlCVnnJ5HeCincIUYMZOz2rbDCroOL0ohmqPVRrbQlFDAubLYRJrl1otEp3r0e2wJZD+iQzZpAL29C1Bcb+d6AzBt56soCGiQbEc1Pw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zcrajdkUUZBZUZF5yPksTK6qW2UDHJzmSNjp/g078A=;
 b=I/kNKZ13swi+iJCKkM6XfRTQH4cCcToy0S8ZZz4Dw81oc+6325zfvzi4IlOm4Fnfc5gFufnoK3Do1hukPxqzS9HPm2Kh8Rp3/wYAgvTuv1Q58nEVW5QlnTCheJxrpQ4NKsWSm9IGlbWqowk9zclmGBWJN8AIni46xa8jrvYB3Lt+z6ZOXaJxmhCIReatlw2P61/qz2gkWwCZ5+x01+7Ze+lNhKP9WMc8DS9PXZlXHh04PUIUx8B3fHXtIf6hzQd4zvkgGwECCd9Xfu3+id8wy4Xb/6lFMDt5OL51vxtcVoXfOMrVju6W9QFH95k7+pjaSJuruZMkUtNMzpUog8Juww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zcrajdkUUZBZUZF5yPksTK6qW2UDHJzmSNjp/g078A=;
 b=Sn+HhGLR8ZRFN2YQSqldX5yvGItutr38Brak1DaF6k6LInPS4BHD48Tpc/+GUtplY6VjqUcPQQ1JBzj67tToU2y6Ik5sXI/rqydv3njIJa242gvu1WA6r1ww+ANciNuFkzhUnvtzsrHVMJoDKfASN4ylymersFqqN8ZixTaWE9M=
Received: from FR0P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::22)
 by DB6PR08MB2934.eurprd08.prod.outlook.com (2603:10a6:6:19::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 08:53:29 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:15:cafe::95) by FR0P281CA0017.outlook.office365.com
 (2603:10a6:d10:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Wed, 10 Aug 2022 08:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 08:53:29 +0000
Received: ("Tessian outbound fa99bf31ee7d:v123"); Wed, 10 Aug 2022 08:53:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 29ce6e0b6d8c9bd1
X-CR-MTA-TID: 64aa7808
Received: from 4934518a5780.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E1585D37-A9AD-463A-BE13-15C91CE8471D.1;
        Wed, 10 Aug 2022 08:53:18 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4934518a5780.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 10 Aug 2022 08:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLaPXjqtIfbhZ0sj1MmGOsIS5hrCGCbGIfv8EIbNBPV7DMBbNajyZMFkjANMV9x3XLiG1CyMAitNeBsXLBW2QsdrG1D02KLA51xM2Jl1L5UIrGH2i1bfFbVyHjgaFHLrlxQGNyJkEGS9etMPoQd6ZGLvaKbXqGW2drROLhBTJJRzUER6osFfW/W+Cs/n6memAroB1+cEgwvnDgikFSaNlGQ9tppovZrSa9EgRIKSfrdvQi5Tk6eZIeiJs/lI5It+fOGwXUENuD+AANOvod7j4/YBPRv3NvEmBTljawfRZgsFVWn4ocaXoV2Qw75ADJUCa796lwERv/dsQywuI1FLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zcrajdkUUZBZUZF5yPksTK6qW2UDHJzmSNjp/g078A=;
 b=Hc2pPzbBmLp4TvgB9ZU3pRAg/4fhvHLglQkKoKrbMHBt5fYeD0tNvkY4DJy3HMPvhkkKDEyNYRbW/04H7leqIU+BVvdDxFjnMtvwoPXutQ1WJC+MU4fVm5uMtbKFOt8ewfdF6L7thjIEZ3uBVZ2bffNV1YP+1bRrzNC7opth1g8TgKo6Qf08RjR114/IHebqVVuEIxjg2ToiEzHhZBgaQrcE8w5k+tP1giB6qCiWhzJfAdZ2GsWY/cNMOSMDcUYbmBylAwfHwN5jWs98N6U8O7k8rdlvayN4QJT6pNaz9EN4YWchb2iGoEX44rvAsOyiUgplDMvxhwJ+k+4NS/jb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zcrajdkUUZBZUZF5yPksTK6qW2UDHJzmSNjp/g078A=;
 b=Sn+HhGLR8ZRFN2YQSqldX5yvGItutr38Brak1DaF6k6LInPS4BHD48Tpc/+GUtplY6VjqUcPQQ1JBzj67tToU2y6Ik5sXI/rqydv3njIJa242gvu1WA6r1ww+ANciNuFkzhUnvtzsrHVMJoDKfASN4ylymersFqqN8ZixTaWE9M=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by HE1PR0801MB2027.eurprd08.prod.outlook.com (2603:10a6:3:4f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 08:53:14 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 08:53:14 +0000
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
Thread-Index: AQHYqHOdT73gyPDB9Uq80vSHBXC6162lVXgAgAAFgwCAACJBAIAABLiAgAAEGgCAAAJ0gIAABFqAgACo6oCAABqDYIAAIZGAgABbUgCAAAk8gIAAGVQAgACxJoCAADSMgIAAAahw
Date:   Wed, 10 Aug 2022 08:53:14 +0000
Message-ID: <DBBPR08MB45389F2642CF29EF186E3B22F7659@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
 <DBBPR08MB453870FA5C5D26AADFDF05C7F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvKWP2BcAh/+YKXM@zn.tnic> <YvKrfqAsVLUqW5PN@zn.tnic>
 <DBBPR08MB4538F9C5F3EAC189722F8F61F7659@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvNsLViKcduXz5px@zn.tnic>
In-Reply-To: <YvNsLViKcduXz5px@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 87642260-370d-4fe4-5a91-08da7aadcbe0
x-ms-traffictypediagnostic: HE1PR0801MB2027:EE_|VE1EUR03FT041:EE_|DB6PR08MB2934:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YxNKMjxxvqXa24bZe7tndfIpezXDH1g7Ud0DZGRyeO8elhg87+O4BEJ/55tP3cRhihMH9gIHHlQ/8aUEwNH4SG3DI/WwcXCQPdMlXNcRt9mefRwOBUtqy08bfcvwzcwS/DPfzu8EUsIOzbb2Ows4TD2NwMT/hEXdXZIpmULdUt+HUIILuUqSGY4QIq+WArXWFlCsfUVdokUIdHqdEc35lgHVR0+a1OMjzfWcQ3P/cG/AKY74PrqRYlLI2rEA7SOAT+mkyrHh7GMcfa9mgedUEorBfUdVgtHVvGNuPaEXUTZZvVCfsvz6Kc0R0lr8njgkqXelYsooh/UE+eDf6GIDpSE/cSYLlObDSu115IpX5LD9ZaORsoCdQyS62SEpTTN1SQNvY/8eiZjl670fST2pa1CWJS8F0Kx6yky03Ur1V15AZOiqJ1evHIM+jEbb0+zAj479iPgs663e+4VLDRv9Cft9XyYoABj0D9jPqous7vMILVDDfzP6NQ28lRjJs1cBbxKOhr7EiKMpLGXt7nYIqOl40EC7W8Oap/dmr7nKmzVphQu+IFWxzV+ypjRd//SOoWBBN6IHlf1fz70W0P5n/S7S62cEQEFGIK2mCjKnd+lW64L6vcH/MqkY9gs2iz6A8FJLbo6gT70xbGABdU+yjLvbTm5UI2mr9HQQf3MErSgnton6N8VE6dX+RSlErj3kmtHYH1+iN6U8VRQDVUZq6hkuStyWZxLQ5kfvUGKCKW15ask+zE9pdXVU0j8RUn0F2+vs0BxYNjbrhslGStigF9bxG/idoOJArP9PWrWufNfbIhiSBeupE2Mxp10kggHd
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(41300700001)(9686003)(7696005)(122000001)(86362001)(38100700002)(26005)(76116006)(6506007)(38070700005)(53546011)(83380400001)(186003)(64756008)(66556008)(66446008)(66476007)(4326008)(5660300002)(7416002)(2906002)(52536014)(8936002)(54906003)(224303003)(33656002)(316002)(6916009)(55016003)(66946007)(71200400001)(478600001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2027
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2cfe024c-09ca-4533-0415-08da7aadc2c7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2UXiLpTspRdr5UJwc1zY7hqyQKifwHQhwexxv3w7/b4x9/1Wg1OgwEiWyD75FKWIbd3FhOfMzPOWSs+wmdVXJ5tAoBXm6Wm4il0NOz+Q3NtqPd0uQgaypC79JLBcne5doJ4zKqF6/nbBE5XT/Zw9p2nYC0BGvb1q/BevQwIrTsSMEEgXp+qn6oNQYBtrRUW/o5byrWhcMk68AJBt2eqUsP33MIG7GU3C3NS3GAsMATIYikLab3g+nV+ca+CBtxDXgE0heWVC4TeX4ws7ahvGmCUsBmPvZjCV3fsJOobDSMJwkcPc3E2Ik2AYFAvqpX0fmKQJjGF/se7bFeT/NNzmzK6DeQdPdepK/K5gnvzE++4NKa2Vl1nWFnKtwWlpUu3KeNVysAkW0P4qrFsSXtQwshv5oOhQWrnUCqI1hSyul8WzdAacv/tW6tWjefjer8hok6M8PbFtsAk1DlkZuYgDMt++CJ44WW+zmDqOBfpqz3kZk+c7X35XI2I3b6JOc1TFjT+GAU5C4cvN2+e/FI0W0Es1ppWr+Htpi4kDF/wVwfWALNFjScIxT53MdlliM7WOu4Dth9E2FIylJpcOs1ZW41u0OlBHKfxf9LlVS/g02phYCpN66BIFDd/MWolL/Sua4sIuEU1XvGlHjhXSIxiXjPlAOQtjs1O2kzGsBCiT0A27CtgBV7/5miG2dznKoGMXDlMpQ9oBObFzjFQ/iJE3obSCUJfwCvu1V/ygNZB2UeuCYC6RcqL2ZOpwMjn1934D/RD82fHKr/2aCIMOepvk/xuMBtPo5vFL015ki6n59jHclIgKjJ7AHvr2o0ugsA4
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(54906003)(450100002)(82310400005)(224303003)(33656002)(52536014)(40480700001)(316002)(478600001)(55016003)(6862004)(8936002)(70586007)(70206006)(26005)(41300700001)(86362001)(6506007)(53546011)(7696005)(9686003)(82740400003)(81166007)(36860700001)(4326008)(40460700003)(356005)(336012)(47076005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 08:53:29.3036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87642260-370d-4fe4-5a91-08da7aadcbe0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2934
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDEwLCAyMDIyIDQ6Mjgg
UE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBLYW5pLCBUb3No
aSA8dG9zaGkua2FuaUBocGUuY29tPjsgUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwu
b3JnPjsNCj4gTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBKYW1lcyBNb3JzZSA8SmFtZXMu
TW9yc2VAYXJtLmNvbT47DQo+IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IE1hdXJv
IENhcnZhbGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgUm9iZXJ0IFJpY2h0ZXIg
PHJyaWNAa2VybmVsLm9yZz47IFNodWFpIFh1ZQ0KPiA8eHVlc2h1YWlAbGludXguYWxpYmFiYS5j
b20+OyBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPjsgQUNQSQ0KPiBEZXZlbCBN
YWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFp
bGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0OkVE
QUMtQ09SRQ0KPiA8bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiDl
m57lpI06IFtQQVRDSF0gQUNQSTogQVBFSTogbW92ZSBlZGFjX2luaXQgYWhlYWQgb2YgZ2hlcw0K
PiBwbGF0Zm9ybSBkcnYgcmVnaXN0ZXINCj4gDQo+IE9uIFdlZCwgQXVnIDEwLCAyMDIyIGF0IDA2
OjAwOjQ5QU0gKzAwMDAsIEp1c3RpbiBIZSB3cm90ZToNCj4gPiBJcyB0aGlzIHN0cmFuZ2Ugb3Ig
YW55IG90aGVyIHNpZGUgZWZmZWN0cz8NCj4gDQo+IFRoaXMgaXMgbm8gZGlmZmVyZW50IHRoYW4g
d2hhdCB3ZSBkbyBub3cgb24geDg2IE1DQS4NCj4gDQo+IElmIHRoZSBsb2dnaW5nIG1hY2hpbmVy
eSBpcyBtb2R1bGVzLCB0aGV5IGNvbnN1bWUgZXJyb3IgcmVjb3JkcyBvbmx5IHdoZW4NCj4gbG9h
ZGVkLg0KT2ssIGdvdCBpdCwgdGhhbmtzIGEgbG90DQpGcm9tIG15IGxvY2FsIHRlc3RpbmcsIGFm
dGVyIHRoZSBwcm92aWRlZCBwYXRjaCBmcm9tIHlvdSArIG5vdGlmaWVyIHJlZ2lzdGVyLg0KSXQg
d29ya3MgYWZ0ZXIgSSByZXNvbHZlZCBhIGZldyBvdGhlciBpc3N1ZXMuDQoNCldoZW4gSSB2ZXJp
ZnkgZGlmZmVyZW50IGJ1aWxkaW5nIGtjb25maWcoWDg2L0FybTY0LCBnaGVzX2VkYWNbTV0vWypd
KSwgYW5kIGJvb3RpbmcsIEkgd2lsbCBzZW5kIG91dA0KdGhlIG5ldyB2ZXJzaW9uLg0KDQoNCj4g
DQo+IEJ0dywgcGxzIGdldCByaWQgb2YgdGhpcyBpZiB5b3Ugd2FudCB0byBiZSBwb3N0aW5nIG9u
IHB1YmxpYyBtYWlsaW5nIGxpc3RzLiBZb3UgY2FuDQo+IGFzayB5b3VyIG90aGVyIEFSTSBjb2xs
ZWFndWVzIGhvdyB0aGV5IHNvbHZlZCBpdC4gOikNCj4gDQpTb3JyeSwgbWlzc2VkIG9uZSBjb25m
aWd1cmF0aW9uIGluIHRoZSBtYWlsYm94IOKYuQ0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEpp
YSBIZSkNCg0KDQo=
