Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F23A8689
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 18:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhFOQel (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 12:34:41 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:61745
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229734AbhFOQek (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Jun 2021 12:34:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZuZ+K44QtVhPpf5h8o56ayvueaohXRw4BKZBOydw61419H7Gn03lLt1PMteYMZ76rnbOq0mNf90vL56pibGcRupcJLM92MeQh1NjN8n4r4sPH1jCqKOY9hur/y5sGM/cAw4wLnWHgD+vdkKcfqpriWJVfF/NGjICMqXP1e1X/uLhqZW8jYe7TqoIjKeO9Hu14yc3l29dn0AO0MCdGYkIz8UmWj7DpcMbu/+UOT3iw9SXR7O9Gu37cbRvEC8LCJdfAYgji9HrbT9DX0GKI6C4ZVIZH3fa2ivkMvFJMUcHehg560/0of7SGgVjcKRbaX/bCt7dQFrWMNgpXGxMSIzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffGzaMJ9JD8Iu6DRjns+20SXco/5xAEH76sqLUdvNMY=;
 b=Dr4fwmwJRBUcNCIJi+6wO+vg8iKl0UCf2QQxcufzdR+VZvg+jvhIKcW4zCUeEZdWGz90pQbxPZXdR2naXynXGtCpcccKL59bUdryBs10x8XZGN99fPnTUNEPBXh9Nquf0mlfv/3QEFpqjP6owrAIHP2P9j9FcT05vKxtWruqQOCbgvyjKi1G+dvQxe1EwSAGyZ3DcWEJGFaSw/aJ1Nf2yX5w6qMcWC5ym81cp3C/saqxYibn5pWaxdoU1OcxtDpgkHbDmERLYDeVf7sYFcXHCPHTVZPxmDhqzW6Zgi/S3jcsvp7uSyJeC7i/ZnrXI4HaWhWbA0iXsrr5mgnRGJ2i2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffGzaMJ9JD8Iu6DRjns+20SXco/5xAEH76sqLUdvNMY=;
 b=t7x8mxPS8U7tGmID9TVD4Q+GCtL19tz2qbcbBKFz7AVmMKv4VQrXNPoH2qypp2yp8PriFms/3gGvPqObFJ+e8pVN/LX1VIZbuQVrEHKsYm8wlTtfJMm+2Bkinxa6yeJnY+H2LhG95o+Pd86uF3oLe7y8SV3rj5iaJNbh/U4LlSc=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 16:32:34 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 16:32:34 +0000
Date:   Tue, 15 Jun 2021 12:32:21 -0400
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
Message-ID: <20210615163221.GA2991@aus-x-yghannam.amd.com>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
 <20210615150846.GA409@aus-x-yghannam.amd.com>
 <YMjE2iwRFWVrfzLL@zn.tnic>
 <20210615160009.GA29258@aus-x-yghannam.amd.com>
 <YMjRGFiqp2HNWUrZ@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMjRGFiqp2HNWUrZ@zn.tnic>
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN9PR03CA0984.namprd03.prod.outlook.com
 (2603:10b6:408:109::29) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 15 Jun 2021 16:32:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2626dd0-5aa4-4500-c520-08d9301b2df1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073733260E7F4FF7228462FF8309@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLRwD+qsdGllg2HyA6XGNAx151aDvgHq8Jq6lnO46c7+oQronJdaLfH2BDdtvIBg2ML9tt4IkAu0r9vMNAEy1e9JutLomNo1JBJiSr3BGkSCj7OEny0zMHu84z7ogdHYH2aU7UP051UqJ7U4eeOUKGJwNVU0S1TLXR/ixhDREAgo67yAYxCWRGZG3a4SdqQVaETLOvtLAM6TS76wDr17OwsZ/tYJIWEjdWHiBPOgGFFPOrWkRG+wYXru23lrkRaLKvwhcl8jQtH8W1XTBt0FM186QXgkGyzyHELBv66XIJYramqTrvSy5l03j463MdrsBbHWj3CltVGdPKXfIBV4lXUW5Wo+/TP5Gw25R6R2bcFhGfjxskSHoPXg1OU4m41dmcDbeM+Z/o6RE6VlXDogEDKVrqCnn7mxBu9yCU+ayF6iU+cINY+0OKaSoyYwy2g7D76qPpk9D4ufJi1HuVRdLreVSOqid38TGrQ/0i+JKv0MXaHWfoZJIljBBCHQxsFb0PlmteR8m2fSP0Qx/hoMZdXMf0ICYwGX2zXwkeR+EdTmsvqchTnxAAvDDOAfRoPwe9evs55lU2I4i70UsnPDRTJ3Fwk6TLjOH1d9taBW48fkLOiKe8vELmvvanV6zA/ZrsESNrfiv6a7aUYTVnG5IX7b/hfJn26RXgq1xm00g1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(478600001)(86362001)(6916009)(8936002)(5660300002)(44832011)(33656002)(16526019)(4326008)(26005)(6666004)(186003)(956004)(38350700002)(316002)(8676002)(7696005)(55016002)(52116002)(54906003)(2906002)(83380400001)(66556008)(1076003)(38100700002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YEYBwlZe5DS93aKohql0GEzN64YlJoPSOf26+enZVmEH1rbMuGnjW0b8I/lK?=
 =?us-ascii?Q?7sFmyC6C45lrFSZ4Tt99rIuG3KdCR4UjI/dI/WND5H3GVZCfALmxXcfmfT62?=
 =?us-ascii?Q?jTHcKCan/Q7zKCWnTTzlRRJ0N7kk1YH16qx7FDptWfrLgAXLCVPiTrzJah8u?=
 =?us-ascii?Q?2cdWxsHFztBn/8TYzQBeZwXCbUeiUGW4ABL6e+E1ZYWKT5RjAIz6dtXhRzQ5?=
 =?us-ascii?Q?GjVfGv7XQYdkqmGVpdsX6RtRxSkxii5VcbOwK/sA2TgwKpESpd+UFom8FuX0?=
 =?us-ascii?Q?lYuf0Z9zvyYKrPQ0PBHWTr9DSuN9A2R2QWYEN/+rtkbhvvlBMvnRJxEHBdKf?=
 =?us-ascii?Q?QbKJKJERMNexlEC0FY8nFX8i/Z6R6EJp/cR+zu3Hmyo1a6Qnsy4SuVq0TWN8?=
 =?us-ascii?Q?E21ynqFIqPzYhZ7WFGhmaYWWmwuWf0zv3WTTYoIxzxAG6yw5iiqtHDe76Dxb?=
 =?us-ascii?Q?vlB2Ez2dpnczB72UefL3HQ4qLkezYHkBP8QgQCGEXdd1CcD3+mxL2ZSXM77g?=
 =?us-ascii?Q?ev2/0rwqL0LZdc4FxmJO8TUvODq12YCPxdPCxm8LpuEVOdOG+2Z0CYaZTVdJ?=
 =?us-ascii?Q?K2BjZlb8LwVD2L67FfK1CkIq2/r/uhf2FVQcZ9voxojwAZ2hZlo5AjCy4Apw?=
 =?us-ascii?Q?Q+8A5wRDePUydpMmqmNXeApQeHKbS4NKeZWbvuuHoX2Od2hFNkiG7m2qX9Zr?=
 =?us-ascii?Q?s1NRfcmUqdVZ2R2smCOP6TXL54kKEoh/4895DcY3vC2M03K4e7IDo9vBQWJI?=
 =?us-ascii?Q?gnjfU0clGBZwMCnqiGjp2ySgjKS+RZfe9K8o9MDTheUW2gUddiRFQOr+GIvg?=
 =?us-ascii?Q?Rx9+nc3SsOpLi0j3GXttxVaOPhWvNkAXPs1V8aVlk5wT87KGfSgtqm+Bhb0o?=
 =?us-ascii?Q?TVbYmmAthFAOvNOUUtrmDnG5HyvEsu4BZe247N1JjdiEXn8qxeVKv45tyfHe?=
 =?us-ascii?Q?+oc70QGTsxhv0tyEV1oZO4AxvStaJMkNJR/NdsrCsxDqBro2CJjEnotGSRZq?=
 =?us-ascii?Q?NIij4YZwlIvWX2FILEq2gxMONmbKUUWAcBjg2Qi7yLpKYOT/k1J8O65b1cot?=
 =?us-ascii?Q?2jwLl4N9ZbUyOuZyqt41ZZfvh6pMa9N0luYhJbFIa0TEVJonZXCLlk7vbdZX?=
 =?us-ascii?Q?PcnejrhR6idt3e79BFjwXv2H7HQawToCcLhAx0EAQMOzelbk2TrhII7EokTo?=
 =?us-ascii?Q?ehRPBPLJb1uz6icsFo/C3IwumH4IPk3Sv2dQHgpCy9n4ezsbtCg9dY0X43yP?=
 =?us-ascii?Q?sD30rR6Ryy6mYJ1ZAGF8mCmkhxmgLoIqYzdq0mBN5pNQTvmMniIFxBT3NwYG?=
 =?us-ascii?Q?X9G95jWwyFCGy+Xrru6f7Vay?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2626dd0-5aa4-4500-c520-08d9301b2df1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 16:32:34.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CPwuAKBaQqMjuc5gmhaSwOlFhsw4SO1Xcgi1m44YLctBg3sp0gwv1XLkVrIzeBaG8LrscpghTIPlqKt7jextA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 06:11:04PM +0200, Borislav Petkov wrote:
> On Tue, Jun 15, 2021 at 12:00:09PM -0400, Yazen Ghannam wrote:
> > So I think we can downgrade this warning to a debug message, if the
> > module stays builtin. And/or we change the default config option to
> > module, and we make sure the module only autoloads in the proper cases.
> > 
> > What do you think?
> 
> I think, as I said before, that we should simply not load this in
> guests. Then this will be taken care of once and for all and we can do
> whatever we want on baremetal, as to what error message to issue and how
> many times to issue it, whether the decoder is builtin or default y or
> yadda yadda.
> 
> Because even if you say in a guest:
> 
> 	pr_warn_once("Decoding supported only on Scalable MCA processors.\n");
> 
> you're kinda misleading because the guest might be an SMCA processor but
> not all features are emulated, including SMCA. So it is not really an
> SMCA processor but some not really existant hybrid or so.
> 
> So since this whole SMCA thing does not apply to virtualization, we
> should simply not load on virt and be done with it.
>

Yes, I agree. I was a bit confused about the X86_FEATURE_HYPERVISOR
thing, but I think I get it. This definitely looks simple to do.

Thanks,
Yazen
