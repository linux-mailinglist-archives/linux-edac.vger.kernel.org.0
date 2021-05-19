Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18B63885BE
	for <lists+linux-edac@lfdr.de>; Wed, 19 May 2021 05:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353214AbhESDxl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 May 2021 23:53:41 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:13633
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353189AbhESDxh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 May 2021 23:53:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ7i+mcNLMb1X5cDMNs1++NOLGPMvb/5kHA3ieJMxDo6IsTpqDCjTauC94p4zHxMO5/AwHjz2UPbba0RZY8q2BwsdYDHQIvxMAf0vld4B5wfCY3jYgB2G6BE3cHek+U5lbwIk28fllV4xFIK+IvXjA7ezofYF9pwZ5xk06bhJvGCSbEhZmC9RF8kbMK27zGS1lX5B/ZOlyPsiIsonNe8/mFNt/UXiFdwIrNc72mltxg34ympgnzb2kHD7aR1KYnvp4wyW48aHCa1aRKCjea+yizciwcm3OfsGl0jyFKNV9HOPiiRWbiLJyZMnlj7CGRVrtqAisio06z6ZuRS38X/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq4L2ED43oW0Y0WDfOOeWM/JNCedp+RK1Z4B/YP9Io8=;
 b=FDNwnlA+qFJUqj3Xb9eRytXsLnpCtM6qhw7IyqLg325lV6PX5gjk8buAYXmkCnOWAD61VeipNgBkbt0ZQca29fAxFrfb1qPzqwGMW0Vl0pbTYH6kBgnb7bRJBFVJzgaj9S8kLjMkxhKsKC1qFT7pggfrq6toFSMFGaua6/V907Y1DKJvc4DI/lyy4LXNS8juGaYtDPUBQwg6ThjlyVhNnqJ3EbQiM5D5lcqnSQwxmvRHzc2/G2yZ/MtMcCqqV+9HGw4OvnH50VhggxmyISwSKLvYn8W1vCOHwaJH6MBHNhavUez3NPpcH1Gj9OmqezGejPh1PJItwYdFNYTG66oV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq4L2ED43oW0Y0WDfOOeWM/JNCedp+RK1Z4B/YP9Io8=;
 b=ikshemmlwP7l7Rjvo1IqZMZFB2/KHLtSMuDmdXpa94UV15JbUzk/2VuBVmNPyj0SiJoyK3MLZE/Bq5tuq+VJonp33iiLbk/wZ1RMILuU50LgAmI3zJwlEjpXgZk/+A6qlOsNmVG9CDjuTXYTiGKHf2zwplc04/WlwYRYXSbwt0k=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2884.namprd12.prod.outlook.com (2603:10b6:408:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 03:52:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 03:52:16 +0000
Date:   Tue, 18 May 2021 23:52:07 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 00/25] AMD MCA Address Translation Updates
Message-ID: <20210519035207.GA8913@aus-x-yghannam.amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
 <YKJoICQzD/o7ZPBp@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKJoICQzD/o7ZPBp@zn.tnic>
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:405:15::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR1701CA0021.namprd17.prod.outlook.com (2603:10b6:405:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 03:52:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae45f6e5-b6e8-4b6e-a5b2-08d91a797e2e
X-MS-TrafficTypeDiagnostic: BN8PR12MB2884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB28843DB3D675B3D9AF06F1C1F82B9@BN8PR12MB2884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyTv/UWXo+K4LzOmQrYsFRPqQFcYQd9AwnclWykiWYvhHOPpdYlGsOb1EPpTmEu0Ck/gg8E//UHK/P4HF8jk/syZEj942qXePZpmbMAyA1XE7+xaM8h91SsZA1zwvxZ2h7IWPBr4+nZ+FIbavyb6NuNRqXrS5fNC9mLS4dV3Jk7NiEcG2UlcloRvB1+N+LiiHRYYcx8OgcIvGjmfV6w5wzWNCeEZ+FeKrw3W4DGx1OE+tdby29JHp4nC73yMIqMf4iXKfpPSioI7bnZ476T6zqNnLgp94pD5V5nfzAwc+vWt05x6s5KMnqIIll/1qv8egCl6a7NZHvYIaiwRFuVIWiAdWFjGd6YHzMtbHMhzu2pz+Y96BG3L+dofmgcK3paRej+Fu0BMNoNdP0OV9eo0KRPt1UjJGbODU9DDuZ0Tc8q1pPw617d60sian/aTMG9V5OVVLnh0fBe87FQ5weDFyDBHYLmGBtsYGNnzdJeyEG4/i1IIOvmP1AWcpTVHubwj9Nw7lAeYGfdPrE55HnPJn0MwYp82de7NZhV4WjJqB2EDfv14cGNR5h/kByI6kLU8P8OXnidYpXF1nb9ECAg2VoK3RgES9KsnlNERtKq7eT3+shWZLZN1ouD6p4fJGygIa0Ec9rQKfiaJDJIeA6gQ/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(44832011)(478600001)(66476007)(6666004)(26005)(7696005)(5660300002)(8676002)(66556008)(33656002)(6916009)(4326008)(8936002)(55016002)(83380400001)(38350700002)(186003)(16526019)(956004)(86362001)(38100700002)(66946007)(1076003)(52116002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J+mYHnpM6tcCDtNmA5Q7SULxRhIjydCIgX1AgkFDwpJZyORXTd0NInqiSEwZ?=
 =?us-ascii?Q?6Iffpmvr//THviW+0c+XLkqtAk7f2ANLpwkmw5KN3jzUJH2WPOhTgVsejMfl?=
 =?us-ascii?Q?PL7/zya05KhkRaSfdUBszieZ4Vj+Axugenn/5QBA14Wr//lOjaoMADkYASwC?=
 =?us-ascii?Q?H4QW4Cq7LFnbGflyRg/7qljWAvQPGIEarn54Ty5G9P8l2QLdKFEXAcojQFbY?=
 =?us-ascii?Q?N+V9GxMnDg7ovoYO3gmtZGtc1BhHAXbAAtDyZuhUn1EN58QQdspMFG4gMfUn?=
 =?us-ascii?Q?dSINKmYLCX3Ct9O4c8lcU/SnRfgfCLjxpc03ux2sRZ/ClIxhEqYRRI8a1lTr?=
 =?us-ascii?Q?hPLy3TvAV0XjwCjt/SkH9Xx1PVDoV9PdxHlDeGbKjKikxgkDUX6sgjqEAEYP?=
 =?us-ascii?Q?cEgFhXgKopIeAb8lmbaKVAcFVIPylvV6+t/d1N6+di9fGgdbut0K8x0ko0Lg?=
 =?us-ascii?Q?eW1ldMnJpnySh9Un/EsbPu9ntbzMFWjPgm60cNJ3vuRY9yjNAQm1i7O8oZpr?=
 =?us-ascii?Q?CuHmD0oBmMUw5FKzhtb4L8fOw4tFeqgtcpV68pJi9kqdJSwUrJqroUoHvn+I?=
 =?us-ascii?Q?Pd+Sl1dFR14lfapbDFGB2XmrW3WMy5uQc9kU1D3hdH6IbBseVQEcnrdKHZwv?=
 =?us-ascii?Q?zivckFd+++qv818n9LpkjkQh+OiKGaA8kwfsoUIUgCapZJH3MY0b7AGUnlkV?=
 =?us-ascii?Q?G0opHXxusHMJZjCD37gmnvzITBhTDvZAGjNPYqDKHvjF1MKUNR7JUdz+NtfW?=
 =?us-ascii?Q?vsm80++a06T2igL1Nnb7Qy8Uk+NQH4zZ/fwsaiF5vNRSXNM677pUmLu94Djr?=
 =?us-ascii?Q?DG45OLWStWduqFgzCX7UC4xeL0iF7JNt5/AdYptjyjYrqujZ8ZAnHmI0X+o9?=
 =?us-ascii?Q?bYeLqu07cO+aEsA0rRnIHYI+MCziBi7kzv22tmcd7h+4w67kJNm/jPLXlSPR?=
 =?us-ascii?Q?A1lZFJgsbga6m3y9mLBkDHgP2qDpwBvDqfh5XONrDcbuPnuAJXlxiLLv9u7t?=
 =?us-ascii?Q?Y4sBBsOj0HERvm3jDx+5I0paFaO5i6BftsO7xVKk5YYsPqyPM4xBPKvp1SCQ?=
 =?us-ascii?Q?cYHyqvog3I40NmhNxiQAz/SUQirBjEjyyokWZUvijwlggfBzec5Y8Y1M8zUE?=
 =?us-ascii?Q?T4Pc9D1mONet8AmBTNnrqoUwamlx3hv/STyXpZW9TgfH5jvT/gO8ZNntxJ64?=
 =?us-ascii?Q?D/hDZAwtTgydzttDFQ5ggQvoELICet4A6shHlLlbr3FkE/LYA3W4rou6X71I?=
 =?us-ascii?Q?hfDwXOB6NH/Ep0FvtoCKURXt8jFuVj9zbpYqRg0lprLooy2d0gib4QiulQBY?=
 =?us-ascii?Q?Yp3sQ1GopyqK1Rn52LIsHZSG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae45f6e5-b6e8-4b6e-a5b2-08d91a797e2e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 03:52:16.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diVYJlFQ0Pcr5SiEYa+TPDH7RUm4MrMKznh0mi2soswA0L0G6eXK089ftuXXFr/WgHkka3xKTOJ9bi+7jKY1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 17, 2021 at 02:57:04PM +0200, Borislav Petkov wrote:
> On Fri, May 07, 2021 at 03:01:15PM -0400, Yazen Ghannam wrote:
> > Patches 1-24 do the refactor without adding new system support. The goal
> > is to break down the translation algorithm into smaller chunks. There
> > are some simple wrapper functions defined. These will be filled in when
> > supporting newer systems. The intention is that new system support can
> > be added without any major refactor. I tried to make a patch for each
> > logical change. There's a bit of churn so as to not break the build with
> > each change. I think many of these patches can be squashed together, if
> > desired. The top level function was split first, then the next level of
> > functions, etc. in a somewhat breadth-first approach.
> 
> No, that's great what you did and keeping each logical change in a
> single patch is a lot easier on everybody involved.
> 
> Now, looking at this - and I know we've talked about this before - but:
> 
> umc_normaddr_to_sysaddr() is used only in amd64_edac.c.
> amd_df_indirect_read() is used only by this function, so how about
> moving both to amd64_edac, where they're needed and then doing the
> refactoring ontop?
> 
> You can simply reuse your current patches - just change the file they
> patch from
> 
> arch/x86/kernel/cpu/mce/amd.c
> 
> to
> 
> drivers/edac/amd64_edac.c
> 
> I went through te umc_... function and AFAICT, it doesn't need any core
> MCE facilities so it should be just fine in EDAC land.
> 
> Or?
>

I think this is a good idea. The only hang up is that we should be using
the output of this function, i.e. the systeme physical address, when
handling memory errors in the MCE notifier blocks. But I have an idea
where we can handle this. I can send that as a follow up series, if
that's okay.

One other issue is what if a user doesn't want to use amd64_edac_mod?
This is more of a user preference and/or configuration issue. Maybe the
module loads, but an uninterested user can tell EDAC to not log errors,
etc.? Or should the translation code live in its own module?

So for version 2, I have 1) Add a glossary of terms, and 2) Move
everything to EDAC. Any other comments?

Thanks,
Yazen
