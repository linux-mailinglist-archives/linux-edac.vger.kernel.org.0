Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B02D8014
	for <lists+linux-edac@lfdr.de>; Fri, 11 Dec 2020 21:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgLKUgd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Dec 2020 15:36:33 -0500
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:15072
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731476AbgLKUgX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Dec 2020 15:36:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnA8u/pQSzV06kRBSZnCW5Z3adOX1t88IunfJqHd6NGsUHb4iwF3pXs7ileaRHTzAZwqCRN4m9MhvPSV+/es0u72amuKU/Bt46sOlG/z8uA77zthUvo8FDAQxYQh7wA/+qt2RFsV35rtDsax4ji+9R7HF3O8p2WSzrNsTlTcXG7qX3IxdIp4CB3FkNQERBXWn5a1S6V3uFHF9fz8m0Q5IBLmXtnMp1TjKZ5yx8TLqaoLCl7292QXxkud5vujGQSSMLECL0tTqNP0RDBVbMlFkLoMuYQjLc2roxM2JJJ/3rbIFybavv64INLV/QnTpIhOqrMjSNbSmzFePXWIaVRdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxIGfzlewGAerJylvW7KkEz+qbiwET9Up9gzGK/bj7Y=;
 b=Vfvsxk0crRbPM2bkLa+PL9khE/HzXCSRLPlNIod5du4hIRG2eZ6sEaNDV7YS+cOmJ/bQe9zxIYJVdRPLODDrGvfABvpj5Sn4XgKLAhel5mCsDjdfsbGitjxSvVguTLBdT+UQcyp6coHqU2YGa4KwSgyO/CJ8gndCZvPr+RQSHUfvXzIUs522ExocYJKnj0Wwll/qzk8lLBX+7SVImZauNhx/d2vvPnxI/GWZv5NKGBvGf7+lCVnCNXd/BwVUo+728krW9qLnsV9XZp0ADvRXMFhx2VCNYnmjuyxEvPTILPI8Gng7P5hJddUMeAfJE9QfQdYmO2lLrVaMQZWWHqXxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxIGfzlewGAerJylvW7KkEz+qbiwET9Up9gzGK/bj7Y=;
 b=YLxhZJRUz135qhJ3j89oa15Wm2/p5L0Qbk9MVCcCFTKIeCcSQ4uqsxAbpSSE9/7560E4PWdZfOipANkEHALbrVa3x/RcgVMOW2OBDR/hk1jSalzDRkyJdwGnjdBZZqJcNWYiLcZkkkShkHd2c74gYUXfsHRbM3LPgGUFHwf59mM=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2884.namprd12.prod.outlook.com (2603:10b6:408:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Fri, 11 Dec
 2020 20:35:27 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3654.012; Fri, 11 Dec 2020
 20:35:26 +0000
Date:   Fri, 11 Dec 2020 14:35:20 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: EDAC instances probing
Message-ID: <20201211203520.GA2128@yaz-nikka.amd.com>
References: <20201211181915.GD25974@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211181915.GD25974@zn.tnic>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Fri, 11 Dec 2020 20:35:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e6b129c-6ed7-4fa9-0e87-08d89e144b22
X-MS-TrafficTypeDiagnostic: BN8PR12MB2884:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2884F88D78620EA7E2E1B868F8CA0@BN8PR12MB2884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcmARIs6s3SW97Wv03NjhnVdR8mdktD/zOotCIh1Xo6hMtq4aOpEP+zc+yUPU5Fmr3rRbOpeVFkCbFcVJzL3SfXfEKLRlJkgS3PTrsorXiiEfv0z/B8FoHeANGNaS5eur9/haakbKD3c7QjWHVbPSwlams5rWW7gaD3Ik3syZTDTqxZHcfc3VB+MpTKUgEI3vuVPRhElu7gRVn0y2wUBgOxXu+qKN2F86T6ELIWqtWlZP7MY17slREsBtXxIG2iix+W6Bbw+prhyEEGn+MfBY1w7FiWOWgPZFzKi7xJCV3DDry/ga2aj43e4ksvg7FwogkGsvxmihA52ZFYDQOpUpD9U9jL2Y//Fc3Uhw/77pmFL4CYZ3kDZvqEv4AugXIyl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(4326008)(52116002)(7696005)(83380400001)(8936002)(86362001)(6666004)(5660300002)(8676002)(26005)(16526019)(186003)(1076003)(33656002)(956004)(34490700003)(44832011)(66556008)(66476007)(55016002)(508600001)(2906002)(54906003)(6916009)(66946007)(7116003)(3480700007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mQA+RZpHzkGJZLEiQ3V/dw4QkbntqRalNygppiq0NoZaHKZ6QP/shW6GDmTD?=
 =?us-ascii?Q?SR89C3vwD4PociGVWY2mn6GbxRyyqPbyelP/yFIFZuOG4r0WZpGlEkl8wpGx?=
 =?us-ascii?Q?xn2vt/GYbTiXaen12JsDfOR714dlYz6z8bgvgdzARj6WZ7Ar/9ZrKjVJXSr/?=
 =?us-ascii?Q?WXxJR7sdOoKmKHrSILg1+NOLtHhatVikybRI9pxQRzs/eJqiaKrRJpFgBjNX?=
 =?us-ascii?Q?F33sNKg0CFQRAYiVHCcYy6DlN8qWSbnrfoYPeL/xRXiEe9kA/PZ/WVEq/PKh?=
 =?us-ascii?Q?UzPg+FB/G/k4T3EHX2YiFQTiyK2KRoshBI45pOnCi+tZXddQcoGx0Cu2V70A?=
 =?us-ascii?Q?4HMneQ/CHYzQ5v2YEr1BU8mFCd0DztXcMSzkuh6U+jgby7Ol3kezO+a1SBWE?=
 =?us-ascii?Q?6FQHrvC5gbr8WkFUY0WFzTmz4qKYXPhWV4yNwuHSocmUGxGBtoWgeDToHUAB?=
 =?us-ascii?Q?QZjdFNMWNwAOmCqyBQqm4MwoX6l93j3XTsTuvgIS2zHHGupE8DXBNKkf98zs?=
 =?us-ascii?Q?jX30ohOYBll8uiez94Hfy+ETkAiyjpmOg+vwiA7vgiJgJjZqMHZ11BjkL/LV?=
 =?us-ascii?Q?mm63LmXXvmMFSbLAyJwL76x5KAtHzxpwdoVM+RFbNNe1l9TcVwdRh8UZaToi?=
 =?us-ascii?Q?y4Ossl65T1DfiUkzrWdZBDPY1BIj3Le408aQfeqnP8ZluQDEtvTJfXQcY/mV?=
 =?us-ascii?Q?lr9gAej+ojh9fjFp367DtBU7+CF+OT4ya6O4M6iDAaGfts9HNfbwkbQz51He?=
 =?us-ascii?Q?rAqpI0Fj6kS1OQqrrErhOa4OzRws8LEitrf3QCOVC/FJ07I0X/03M3FM8WT9?=
 =?us-ascii?Q?KPgTDMtff7M10YmXEJx60pzMtBD3xdjG7XIhJ9IcB1ZW9K4XsW6Lm5wfjFWr?=
 =?us-ascii?Q?dVxULeYEB5GHuhTTiWePzbZrR1bM8s+Z6pfZTRPgac8JBENHT5cHAWKeC8+Q?=
 =?us-ascii?Q?5O54kBDXEL3oZzdBtOEZHLz3+xejw/ouIMdbsmrG1Ew/QFzG56Vxcg6uQ8GW?=
 =?us-ascii?Q?cvoO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 20:35:26.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6b129c-6ed7-4fa9-0e87-08d89e144b22
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1NVaTBKj5u6We1A723GZNhRVFaD6njmmo6dZbdgJ2l1w2/qHxw6/f3Uhv7aL1ZrmNCJWWp+Mmt4EiQO+5ukuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 11, 2020 at 07:19:15PM +0100, Borislav Petkov wrote:
> Hi guys,
> 
> so we converted a couple of EDAC drivers to per-CPU-family autoprobing
> instead of the PCI device IDs one which needed constant adding of new
> device IDs.
> 
> However easy the new probing is, it spams dmesg on each CPU as it tries
> loading on each CPU, when there's no ECC DIMMs or ECC is disabled.
> Here's the output from a 128 CPU box:
> 
> $ grep EDAC dmesg.log | sed 's/\[.*\] //' | sort | uniq -c
>     128 EDAC amd64: F17h detected (node 0).
>     128 EDAC amd64: Node 0: DRAM ECC disabled.
>       1 EDAC MC: Ver: 3.0.0
> 
> that's 2 lines per CPU.
> 
> Btw, people have complained about the spamming.
> 
> So I tried something clumsy, see below, which fixes this into what it
> should say:
> 
> $ dmesg | grep EDAC
> [    2.693470] EDAC MC: Ver: 3.0.0
> [    8.284461] EDAC amd64: F17h detected (node 0).
> [    8.287953] EDAC amd64: Node 0: DRAM ECC disabled.
> [    8.381430] EDAC amd64: F17h detected (node 1).
> [    8.384684] EDAC amd64: Node 1: DRAM ECC disabled.
> [    8.461902] EDAC amd64: F17h detected (node 2).
> [    8.461993] EDAC amd64: Node 2: DRAM ECC disabled.
> [    8.536907] EDAC amd64: F17h detected (node 3).
> [    8.538923] EDAC amd64: Node 3: DRAM ECC disabled.
> [    8.643213] EDAC amd64: F17h detected (node 4).
> [    8.645474] EDAC amd64: Node 4: DRAM ECC disabled.
> [    8.713411] EDAC amd64: F17h detected (node 5).
> [    8.714818] EDAC amd64: Node 5: DRAM ECC disabled.
> [    8.807825] EDAC amd64: F17h detected (node 6).
> [    8.809882] EDAC amd64: Node 6: DRAM ECC disabled.
> [    8.908043] EDAC amd64: F17h detected (node 7).
> [    8.910883] EDAC amd64: Node 7: DRAM ECC disabled.
> 
> Once per driver instance, however each driver accounts an instance -
> logical node, physical node, whatever.
> 
> So it looks like this, do you guys think this is too ugly to live?
>

I think it's okay. But it could even be a single boolean rather than a
bitmap. At least for amd64_edac_mod, the driver will probe all the
Northbridge/Data Fabric instances even if some fail. I don't know if the
same applies to other EDAC modules. Does this issue affect other
modules?

Also, would it make sense to go back to PCI device probing? We've still
needed to add PCI IDs for almost every model group. Probing by PCI
device should help us avoid this issue and also prevent some messages
where PCI IDs aren't found for supported families. For example, we had
that problem when Family 17h Models 30h-3Fh came out. The module would
load because it recognized Family 17h, but it would fail because the new
PCI IDs for Models 30h-3Fh were not recognized.

Thanks,
Yazen
