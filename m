Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927861DB5FC
	for <lists+linux-edac@lfdr.de>; Wed, 20 May 2020 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETOML (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 May 2020 10:12:11 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24270 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbgETOML (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 20 May 2020 10:12:11 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KE0WNQ031738;
        Wed, 20 May 2020 07:11:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=XQnxEBghylMP2upIJy5d4kWbqr82RpqmQGYMxT0ahsI=;
 b=p8nyKhJXXGJPEIK7JFbNRlN8kAyKsZkdRucGWRS4VK+u2lGw22qTgQumOOa8GcC2aIo1
 O9hbg6wpc4rc638jbRboLgTXzhP9Pl32W02OKBirtzYg3JJdit1CUHvQmWvhklC0nsVX
 OmZi+9OQ0SW/+dChEuF3YWAnhXKIOU9IPrUqf2H96Rambl3aqA0YFGD2dr2O/7F/ek4N
 9R4EELdWbNDaX83l0ErEJhtC1Y+7aHaC7l8QQq3UL+51PsouNRJuFjse8c62SrOmucTk
 GbCoQr4ga8PcvrhU+erhINanoQN7QlFgz4lFSYaZ+1OfiuwSTzppbQTVZ/JQFLOouqfd nQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 312dhqs8u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 07:11:52 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 May
 2020 07:11:50 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 May
 2020 07:11:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 20 May 2020 07:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egz0V9K9IBngTGZ+44R3WdSQkGI4PXrZcQJU9wiNBqixWRJOFZUC8ZNtRxLEegytwSI/EQ5ABIlychAAI5Sw6qOacM+NsGJZE2z/xm2BE13mlUXfM0Or9rCp3fg33P7VmRffOV79CB5F6xljx2mwLt/UkTI3JGx6gB2VMUxDG8n2AN2Wm7u3HjNpCaGcADf2quecixUDZLSw2U+Z/rVDQwynU6YhZtBDCFhCywzUV/mHWsyUzJhbArWN3PGQAJh97F+k4MsjfnDW3vGao5OsKW+VCV9ESeeGUBkTyBG+tmL8SfVCm4fHEfdOXftSHbWVCm6oiBkQIkouvrmYWZz4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQnxEBghylMP2upIJy5d4kWbqr82RpqmQGYMxT0ahsI=;
 b=XMU0wIgBN24bU14MBaK+C19MbJfY1igTqpQ4E9ebXx7emggy24D/qZQzCuAugS6xeCkoCur1Eoz3sIJ8r2aoEDEkgSLJPUU82d8uEX5tkpvGWlE48qeVS0tSlYN0C/eDZeapRdMb+mbsXT8t/rW0XkkktcPywWR2lI0RpnZ/9b0AIvA4KFrWZtX+K9QAN4OCUDf7NKGpnilFMaDRBKQJy5MyVhqAIMwTqpZq5GSI4k6bHcfcaPogc8bHXmlQ2IpuGOX8WIzAbwzx6/mHwxHUlno0loXX/6WOeUC/gSIRs+VEgmtlhsDczpnGANa+iOmArJVGKxsTTG+ozX3YevXejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQnxEBghylMP2upIJy5d4kWbqr82RpqmQGYMxT0ahsI=;
 b=if0Rs/aw/of3EqhQ+V9TZNuJoUfKZywFLRWw35eaSXcinYeg4fxbJNW1bSwZHS2tR/iKPWm+qdqu8P1hY8p2poKhNdTKDydKeAPD/4uvwLOL2ZD52bLpZZDxFGW6O4CndNvQswuMQPcDrqg/of7CEoIV1QKWtznCVQG+K1Qao9Y=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2517.namprd18.prod.outlook.com (2603:10b6:a03:135::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 20 May
 2020 14:11:47 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 14:11:47 +0000
Date:   Wed, 20 May 2020 16:11:37 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] EDAC/ghes: Setup DIMM label from DMI and use it in
 error reports
Message-ID: <20200520141137.5do7eiaoodmgxjsa@rric.localdomain>
References: <20200518095852.28010-1-rrichter@marvell.com>
 <20200519202535.GC444@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519202535.GC444@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0308.eurprd05.prod.outlook.com
 (2603:10a6:7:93::39) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0308.eurprd05.prod.outlook.com (2603:10a6:7:93::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 14:11:45 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e527975-cb1a-4b7e-fd75-08d7fcc7bb85
X-MS-TrafficTypeDiagnostic: BYAPR18MB2517:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2517933241B61F4934B3690AD9B60@BYAPR18MB2517.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbjYjWLzqixdUEiEm+LD/Gy1Cy9O/tAiiK1ua/aZq1+tW70dADuW+hj/ZqtK9UbWg6qDN84ESJmzuhCg+QBnAQoWuVvGzTyo4e0wRefSzB8ZAbLQZaEJ4x/1nkPXlbvZwHILTHoH16Wzhs7H3uYcXG9+Jm5//idrcl0Y9PYCGwMFZCxUZkvwVYzvyxj6gW++coSWjaxJdn6szw6KOh5ZxqZz6+UeUvoQelnuvz7z/t2qYUmO8hd5OzAzqWDjU8e7lOpFByxS3R3syRXljjvCCpEM2t0ZGfrByJrF0zUOWxBFJPTncQoWv+on7cUOumnl/Kl4IPdCNVkmGya9tncXIftF+xzMD2ToDL9um2VSTDpxpnN2v2HLGzqNQfLjqlHkPe+rC/+qybdvjoBS/0wBuQVkuFZtOHHUMGKQQsyXDQz44JASlZV1PIDnVBt8MaBS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(6916009)(6666004)(26005)(66946007)(2906002)(9686003)(66556008)(86362001)(66476007)(956004)(53546011)(6506007)(5660300002)(55016002)(478600001)(54906003)(1076003)(7696005)(52116002)(186003)(16526019)(316002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2kH3DQXMxFgzmO2GHOSNLslxwEy2I3mJ+2fddvIy0Y+PZjDaq+LQ2fSzkvVC9vWPKkHhq/9MuShLs2OuT6oXfqPbZJ74ebQQs4WPEst8AsGh+VTkYgdPlaCEwXOOYrmDeZTPfNvoVpGEEE3iWY8ET+7yMn5Z9HEr9YWvQUvkK/daYsMuzCj0hUlwsABOkogc13W+QYwWW7jwBA1AyT5vj/3HTALc09uiprsnpV43mAVOZ4mixoiDyFZm8ytu7wsiPD/rypM2W3tMIDuD2k097eyC7YZPds9FAsvXfrrgOadA0/YEO55s4+g46sDu7X57MZIiZEIJRXNqFFGMH7ckYyZoabGGCp81yhcEkllVxrL3IhM3kFzh2wN7SfyQDePHm95EPF1cVR3Bk3ay+dBa8RRt30HhMhLwgHH/kPUZ1rNbF5B4jwFzbWRPHdOLQeiNE+CYkb+oE+GWsBYiBF9O18ZFb9A/Q+HSpHw1P/bqUMo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e527975-cb1a-4b7e-fd75-08d7fcc7bb85
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 14:11:47.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+YPyTWlaP5nBiw2ZowmI96sEciqukNPeFlq5bQ5zcx9ao6BzQOBUdYE9jwgWZSwpKitKFEw0FvgP1AOK5B86g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2517
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_09:2020-05-20,2020-05-20 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thanks for testing.

On 19.05.20 22:25:35, Borislav Petkov wrote:

> -/sys/devices/system/edac/mc/mc0/csrow15/ch0_dimm_label:1:mc#0memory#15
> +/sys/devices/system/edac/mc/mc0/csrow15/ch0_dimm_label:1:unknown memory (handle: 0x0030)

Looks like on that system device locator or bank locator (or both) are
empty. What shows this (esp. the Locator fields):?

 dmidecode -t 17

So maybe the check is too strict and we should allow one of both being
empty?

If the strings are missing, shouldn't we still provide the handle in
the label information?

The string 'mc#0memory#15' is also of no use as it just takes the
mc_num and dimm_num as a reference, which can be determined from sysfs
without that label.

Your add on patch to just ignore the write does not revert to we old
behavior as you will see now 'mc#0memory#15' in the error reports
where you have seen 'unknown label' before.

So the question is what to do if that information is missing?

Note: it should better show "unknown label ..." instead of "unknown
memory ...".

Thanks,

-Robert
