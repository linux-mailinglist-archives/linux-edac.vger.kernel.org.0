Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB33A85E1
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhFOQCj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 12:02:39 -0400
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:18401
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231841AbhFOQC0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Jun 2021 12:02:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apzjssW2rEdoeV8aivr052cLM3FpzltzI1j/ZXOZHytvtrpt9+kox7YT8ELIvGxcb8cxjb84q7lj4mtnVIp3eRLWJxaxIPcpeytuXrWacdtDjo8cAxGQ3+3ENMo+LpmzfxBmlqCypFNsJfHFCQm/KKIVuapD7jxIc7jBI+LLqt1aOU1PfkLgcWHRanPFxlEoTppVfxMlKzFZmJcLLG+n2bXPa2bWw0BkbnT6Koh/xfYn+wNAGGxa6/t7S8NKCvFm+40HPoJA76BoYPAZayjmTCv5dfopKjWCb9LB3oPXuyBasvw51T+SL6MtSTaDeUjeIFqIGjghaMSqdsaamAtB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsA9HuxzaOyTGnyD3daDBGcr7+tjmUANWB+AQjxcpL8=;
 b=gahna+dbKkGJ8ovdLKe4B70rZjlv25AOKBrQBprOB1V4os0veuF4CmYe0zjyPz4d6u5das2w6I6Jnx3Xxh3afCEC6ytT46+U+eigvbPXu/O0+eNtRWVxvjei4ywsbJMQwj1LkGRSZK6C/yUwpT5W5E+u5L1PtxgUXiYbVHzgvafr0eQmXubycEfziu59K8nHrOtjyJ9gBYEjlCiqxqqPtNPoK9kPV0V1d0L9nPaiDmv14ywGuDxpBqD5DyMlbtADAx25pcxQFHZ7Wicjg3jcO4UXjJ6oj81dA8k7qx3rkEr67z6y2rD5AJy7Z2MdS0XY6kM/dX85JpsF/nmT+lGNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsA9HuxzaOyTGnyD3daDBGcr7+tjmUANWB+AQjxcpL8=;
 b=EvnQHy6ULNmaDeXQreg58H1gwaXF4BSObdAkDK0pDZQ9V6wOMjq4acVQ257LNu24B+/Zgdgwp3q3hfHN2ZIgryAP0D3BvTpgyzkLdfTD0hFAdky5W8GXqm0tIyoavm1NnrdE4kwplJ+/adIXdFlZk+yYS6rDNUeSV88oyk4io5c=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 15 Jun
 2021 16:00:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 16:00:18 +0000
Date:   Tue, 15 Jun 2021 12:00:09 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA
 feature bit is not exposed
Message-ID: <20210615160009.GA29258@aus-x-yghannam.amd.com>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
 <20210615150846.GA409@aus-x-yghannam.amd.com>
 <YMjE2iwRFWVrfzLL@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMjE2iwRFWVrfzLL@zn.tnic>
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:408:e6::21) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:e6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 16:00:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1c54758-d5b5-4359-fbed-08d93016abbf
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB328202C3966DCD04FD6E4DF7F8309@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0V71xS5Durm/7rxcusj6+YB8kkn0Wf7sG7u5vcg84Zuvm0fvo6IzCTo6xFipYXLsfF91Tja06lXJrVNr3u1vsWl7/ieUzcORDBXRa+3B87xoeuS4A5lhycSfekqgBSEGcFKYd0mprHhs9/afIb7T/0cBwG7/1EKrqSMz8Tgda+NXp5V4secmMoFf49x9Sn3F/q+y8rXxqG9ZIFFuqlwjEkyk1ls/XTxN/Xk3dQwyLBcqnP3EHkv3XaQLc5hJpqJ1P4FMYTCK9wwLx1vGAXc2dIhBV3JsBIz7meWtYR+da6xTSZjdCzV4qDS2E1O3nXeYePJRZyq9FtSNzTC3RXXxUNKtq9OTMYnMMv0aG+U+Rc+8xpUdInYQtjrvm0CAcYlgGBNpF2MNKzx0gaKJqTrb9cPrclpU6nMLfjj1w9YP+BuFLRFmjk1wdgIbKCAF/pd5J+PJnyS1IHyHp5FFya66Y8PL41cwoN6462Rb8HYnbnYf9rAAxNUMSjVRnYkU3YYV7qgh4knA/vYLWJ1mSJ5STLWgo7mtCgch76sCRQD0uH1Lud0w4o/y9ew/EKrmDob5jZ413UCk69OVPSsm28LodfzdZ5QTcPLRWwj2SxRFcBk6mM1grOqKpSK+ft1+IOcgSfysG8QR0Bly3DdSnn4x8WexP+RDzVZUa7BRhunaWSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(8936002)(956004)(52116002)(44832011)(5660300002)(86362001)(6666004)(33656002)(54906003)(38350700002)(83380400001)(7696005)(38100700002)(66476007)(4326008)(8676002)(6916009)(66946007)(1076003)(186003)(16526019)(316002)(55016002)(26005)(2906002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjFAv5vFI3OsiEVNxkSvqhfGAjZGk7gJWKIVcfQt5uunVUSdBEB/gosdyZRx?=
 =?us-ascii?Q?YfmyaJfmIDWAO22TFrM2/h/R+0UmsKEiUCTVUBat5Emz3lZzahZS2WTnKlpB?=
 =?us-ascii?Q?GfqPmfX5wfpl+Rt0ubroVUJKusGwAUasu3075tvgCWC1/WJCjAN0DXuqz8oB?=
 =?us-ascii?Q?V6mu5GiXgfNe8fAPKCF1GVM2uUikmatw1+njm6misFZUdSLVlPEX/nlHcUf2?=
 =?us-ascii?Q?UTLT5ll3iP4u2xDtzPTW969HG5I8HNu5Vv6XZerDLzaUzQmAPWY3AQPp0kG9?=
 =?us-ascii?Q?27ObaxCcdKRmpnCDMP9xqc3pU53cOyJP1ZtzwxVGncI0KPqWAvxubL/XGeIn?=
 =?us-ascii?Q?L2ItxsWsAHDhb5uejHce1meaoKLW7YTivrZYWFfIzYu+UGkEeLApLjxS/7z9?=
 =?us-ascii?Q?mJaic/eEFGktUx41VW2fOGG1aYGOJ0HZ7kPrTPv7U+bUIUAmG4hCo+T1pMG1?=
 =?us-ascii?Q?eerZgoyzXlCDJGqgne0chv96KmABDROEuanY7CEkWT48gcNxFCcqkUYsKoNc?=
 =?us-ascii?Q?SEL9FfoYRxyWbgIqEmXgCIDztGfE5+jLUc5UasNSLJ4/yXr28Baht0nDOU9Q?=
 =?us-ascii?Q?gyia+yNCBAgIulwrsibzYkwbjIYAb6/yOjyKrB9LH5Re0JzW3wykzpQkLaQC?=
 =?us-ascii?Q?or0SiwTzWMv3aqWngWgnrOOTz2VZoyGZrnIwyXLuo1KSzB7cvTFRqpcH6Jz7?=
 =?us-ascii?Q?5YO+C3YnI30y9N2mVu9bf3n/rNw5uMAt0vGjS5JtBD+xnwmp+pH2OdPDfaU0?=
 =?us-ascii?Q?rzcd/po6fMAC10RJ/0Yh82WocNRoDEy/5cdmjXEfF5rfbEWx1Xu11d5p4UXa?=
 =?us-ascii?Q?BGbk4tGAH2RlLIZ2UMsJZmGdPUXRSmlg+T7/scKD1zr7SIaHyY8kv2Zz+Ayf?=
 =?us-ascii?Q?cpg7mU0ukMqncC3zZMv4fOsZvYwB04NLZwnjC5b+BEGwsB9HBrwKJI0t4zpv?=
 =?us-ascii?Q?PYo/ZFIxlmkPkLSnQ4yktZOQbxnWQCr8xUL8RtwLdHcJsXXBueipL+qUgmKS?=
 =?us-ascii?Q?oVU4JGU3+xQ6h3R+LrOlMa5Ubq8Mi1imr3m7vURNnTCFYUt8FFQP5ncvNMEC?=
 =?us-ascii?Q?EzQ/9nVn6MAJamnz3Gbk7C4E+YJmfk+8P80maEXke18XQ39mODt3AY0MC62k?=
 =?us-ascii?Q?P4htwoiSKcy+dr7IZoaRHXXhlFOAJpo76VsWdALi+79YZxx+BwyFapVSpE4G?=
 =?us-ascii?Q?79+KNjiMs4dHXMwWhFS2MyCAPsAu5orovfb6SpftlBM2ks8qFhK5s64nJ7TF?=
 =?us-ascii?Q?M9Rr/F2kQNmZTcUxhuSlVQoAeZjIa9DQZ/QCTMlfXW7TFh4UKUqy4d3DPXY3?=
 =?us-ascii?Q?U3nyb99xmp9wqusOuSVoveAH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c54758-d5b5-4359-fbed-08d93016abbf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 16:00:17.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW5aTYQSnH76Z/dNiJKXrQkOGUGkyt979B4JHSaJAcMFQtcLN/OitJ7TfSXDAp87hcpeVyLG76IEScXj+WoRwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 05:18:50PM +0200, Borislav Petkov wrote:
> On Tue, Jun 15, 2021 at 11:08:46AM -0400, Yazen Ghannam wrote:
> > How about adding the the SMCA feature to the amd64_cpuids[] table in
> > amd64_edac.c?
> > 
> > We can use X86_MATCH_VENDOR_FEATURE to match on AMD (and Hygon) systems
> > with SMCA. And we can remove the X86_MATCH_VENDOR_FAM entries for
> > families 17h-19h.
> 
> Sure. That'll alleviate the need to add new families which support SMCA
> too.
> 
> > I'm assuming the issue is that amd64_edac_mod is autoloading due to the
> > family-based device table, and this will load edac_mce_amd as a
> > dependency.
> 
> Is it?
> 
> We have
> 
> early_initcall(mce_amd_init);
> 
> in mce_amd.c which attempts to load this thing unconditionally.
>

I think edac_mce_amd is usually built as a module by distro configs, so
early_initcall() would be replaced by module_init(). But the default
option is built-in, so you're right about the early_initcall().

Also, you bring up a good point. We can't say to people "don't load the
module" if it's builtin. And I don't think it's fair to say "don't
build-in the module" if the default is "y".

So I think we can downgrade this warning to a debug message, if the
module stays builtin. And/or we change the default config option to
module, and we make sure the module only autoloads in the proper cases.

What do you think?

Thanks,
Yazen
