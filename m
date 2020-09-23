Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33522275D4D
	for <lists+linux-edac@lfdr.de>; Wed, 23 Sep 2020 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIWQZ2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 12:25:28 -0400
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:16737
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgIWQZ2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Sep 2020 12:25:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVVSXuHZyTM0OLncVjtWrLTltsnJ6ILiVYHxnE0AicZp/NqNNBwWdwTnT3nbvakmmDDrCEVCWt8pxmhk90+9c9cqB+RdN0adoETYd1ITNE9ahDoi8k16P5Li9EbNFXyJq9HdwBuITc/1MXMSeaKk42x97iGJRZlyIFkFPboiqrVkBi/ksKWJHD2XMr0T5dU8OnZKzb+VWeMaeO4j+GrwrIsWNlvbCht6RVYpwnFqQsLodbOIiel1FxX7Uz8Gg0WysH/3s2ZCA/pbhkN/Z1MLguGdR7AdIQjgyktfqVCK3+xlzXBRhd0cr0IvnuTR50gEKqyFpFkVNYp1sjfv4miv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLbbufNfAJV5Lzjd0g7rw0SXuKspvjccM0FwwZFQ+08=;
 b=Z51NDf+GrJiQLQgmQtYyGBPeai6NKY7OupjIK0WwbZEFsaIE1QsLACWMRGdymAx0vQ3BaUmzDikg9F3Q0A/Lh+sRkrH5I/kDNEuKkC5CGljBsXyYFym0+vuYbSZMRETqFe16DRRo6x1Z7opSgXFJPQqIvcC2z8TmUh53nH+ZE4CDOa9X31sDAYJudjILKqoy8oLNB0QpY/1n2cqWfprkQrtUauDW+/4RNhHevxNLbmejfaT8bGP3C8dSY48FZFe87tSyub3863GiiPRfSdvZD3v/tLQ2xY+OzusXQW2cbOVYe9T5Rr7xHSrJDbmXZV2tte0+AS4GBNMbDBzD3sJWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLbbufNfAJV5Lzjd0g7rw0SXuKspvjccM0FwwZFQ+08=;
 b=BqANMUabeo44tnMxX5Ha8M+r276LGsUZbbnhTbmXyJ+ZJDTZR9Mts4R5lDS6Ra0D90ZvXoQm89elH58Mewco5KpneOWuGfINMUuQj919M0rxPSSMUB58eAAc6EZxXwZVqjmyYA7TbhSxe+AXJjfNVClAG2ICsh0lqjHFNizVar0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 16:25:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 16:25:24 +0000
Date:   Wed, 23 Sep 2020 11:25:10 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes
 during address translation
Message-ID: <20200923162510.GB1684790@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-9-Yazen.Ghannam@amd.com>
 <20200923082039.GB28545@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923082039.GB28545@zn.tnic>
X-ClientProxiedBy: SN1PR12CA0102.namprd12.prod.outlook.com
 (2603:10b6:802:21::37) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SN1PR12CA0102.namprd12.prod.outlook.com (2603:10b6:802:21::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Wed, 23 Sep 2020 16:25:23 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9b20475-2c9d-469b-e381-08d85fdd45f9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1747913291D18E7153921CADF8380@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcoDPLfXgan12bVPzgf/m9fIxoUwEAKBCtt5ZEh+8sB6wdemgQf7ILKvfF28dX5Tqkg1FcnngXpVPQej3GxQ3SUFIVU1PHqW3Czfp9HUKETHwGWY2ajD0mIVYDVw0JvqbaJ3QMTFL8J627oYQRWpDueWUK/xX9prYdB7eyb30owFqzwjZNSvufLkYb5ma5/Z0bOw3UXTXAQjEvtVxXR9I7CPTrEyIAarqvKoJIaf9+DRDWdBg/PsyIKRuqOpXwFA291cuPMygJU2KkUNIX3qoitfefeswx+sgeXrvKkm8OY7Qv8lrOyrXNwM/fbCLEw51Ay1rwOuSloIgSQuh2lUffmbocS15FinBBegg20lG9Zh7mugk298Mgy8PGsCn1hl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(2906002)(6916009)(316002)(4326008)(186003)(16526019)(83380400001)(26005)(52116002)(7696005)(478600001)(956004)(44832011)(8936002)(66946007)(66476007)(66556008)(86362001)(33656002)(5660300002)(6666004)(8676002)(55016002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Rwe93WzqTGN2SehrwENWQlHxbbow7feypJUhARLGrMQiK+HJleMFxLge5pbNT3uNeD1bLx3Sh5puZ6T/i02uYhsWf5me4oJ4TDfSpdxhNGif3zZBdWGhW8X5xI4FNf96UzgiQRrDw6ktQt9qYAYkVwzgJeI8OLxq2n4cmsPs199XdQQgPwRDuetSM6lZvLILQ/QjlXDJRGQN1IlqdLtSDQXhXewk4JRNj+bkY4dl5KhMd6VbMh41g6W+Fzng8z0ODaATeCJZxve6tZu94Hl0aHvT1wup5dFU4dQ95PZMa8ifPE3dQFFmumYKihHRcHWz2vJPByp+N7tTNltUFiYBuWYX0n4wk1klXmlgejmgT70x/xNT8VOvn5XQ/WLFi+BTVwJaPF17lt/B8f8oZq3hR8NRLNAT6fLwJlzVuWLItIiB2SqR58I7kGLejz1brkUpsV4GKsLWO6i0FhMdlf51txzZ37g32untWIeTzx+l1q2KujF/Tj2uhiWo3xvNnCCR3C+tJRQOk5caf4Y6ZrfZIEGJuIoiuNxsk+l+I/7k1xJ8Wh3BzjIhMm2wjfR9DvsSVSBJrNviFaU7TPC3rMpnwMdeY7j3Ph6xBJ9HPPy20NCgpH3dBxXpCZOWs/lf0XfbGYOn87bzw6kg93BciBuZkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b20475-2c9d-469b-e381-08d85fdd45f9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 16:25:24.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIKzSWXB2Ek3APjJJWePhkhBI9rsUCoAJGOBXhXLheWpoNYesk09Z1qy785WjtGj46SRfE+7Ulu2KZpBeZl4Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 23, 2020 at 10:20:39AM +0200, Borislav Petkov wrote:
> On Thu, Sep 03, 2020 at 08:01:44PM +0000, Yazen Ghannam wrote:
> > From: Muralidhara M K <muralidhara.mk@amd.com>
> > 
> > Add support for new memory interleaving modes used in current AMD systems.
> >
> > Check if the system is using a current Data Fabric version or a legacy
> > version as some bit and register definitions have changed.
> > 
> > Tested on AMD reference platforms with the following memory interleaving
> > options.
> > 
> > Naples
> > - None
> > - Channel
> > - Die
> > - Socket
> > 
> > Rome (NPS = Nodes per Socket)
> > - None
> > - NPS0
> > - NPS1
> > - NPS2
> > - NPS4
> > 
> > The fixes tag refers to the commit that allows amd64_edac_mod to load on
> > Rome systems.
> 
> Err, why? This is adding new stuff to an address translation function.
> How does that fix amd64_edac loading on Rome?
> 
> > The module may report an incorrect system addresses on
> > Rome systems depending on the interleaving option used.
> 
> That doesn't stop it from loading, sorry.
>

Okay, no problem.

> Now, before you guys do any new features, I'd like you to split this
> humongous function umc_normaddr_to_sysaddr() logically into separate
> helpers and each helper does exactly one thing and one thing only.
> 
> Then use a verb in its name: umc_translate_normaddr_to_sysaddr() or so.
>

Okay, will do.

> Also, Yazen, remind me again pls why isn't this function in
> drivers/edac/amd64_edac.c, where it is needed?
> 
> If the reason is not valid anymore, let's move it there before splitting
> so that it doesn't bloat the core code.
>

I don't remember the original reason, and I was recently asked about
this code living in a module. I did some looking after this ask, and I
found that we should be using this translation to get a proper value for
the memory error notifiers to use. So I think we still need to use this
function some way with the core code even if the EDAC interface isn't
used.

I think this set can be split up.

1) Set with patches 1-3 fixed up to use cpu_die_id.
2) Set with the address translation updates.
   a) Move umc_normaddr_to_sysaddr() into a new module under EDAC.
   b) Hook the new module into amd64_edac.c where it's used today.
   c) Refactor the code as you suggested above.
   d) Add the new features.
3) New set that sets up a proper notifier for the address translation.
   a) Unhook the new module from amd64_edac.c.
   b) Register a notifer that runs before any notifiers that operate on
      memory errors.
   c) Find a way to pass the translated address through the chain
      without losing the original value.

What do you think?

Thanks,
Yazen
