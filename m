Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7633A83AC
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFOPLE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 11:11:04 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:19802
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230076AbhFOPLE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Jun 2021 11:11:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbXw3/MaDZ9pPhmIcDWPAa4ljjB+TUVflOuhGQkBn7rLDWx4aEUivbmedjFvG1Y4Frn2/OXNNeju51S4YxXDDJre6blBhPVokmtZf0ec/jS9KO/fGEUZ0uLlABDdwraXZA67ZU0Z3OZAnItVBo1ZG4EbSDTuMzr8vgnagiO604UDHOWcJPjgKGRYdYARwxAffgZlDtBhBLQIl5OceoVOptObIVAgkNEzfXtkvhlX15oyIMYRSUpDdz0hYJVp8fjcVGgKgwOvcqS4t82Zik1wKMnPtfNptjbEFXUR9ytooMwAxmTAn7J+Px1Yt8n763Sm6K88McaXkUK7ISBAD97BgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdIq19lQoD6y6taYyrgLroYs3L+MPDeGYhef4Sn4Ogg=;
 b=VFduU2lG2Gz3aV7RE+qaJ7LI7/RCq4l4uXGMfllojFbqZUUdLnqwFgV3Q8DqA7/PlDmAysKGdkn3Rrw7eLLAumL6z7OpKWGxcK9lB80OVkv0JpbEgxz8G3Huugrby4073xEilCo6j/RCL4EHM4E5E64h53Gc2KXArXnNiYvHpGIZ7aq7NT3h83wNCkvSXkJryACb0m46n6Qu80L7DhPaFY9XGCbaUFvVDU7igYfMYGGYEYg2wSSqLlMeX7qbw2x+xY3yxzNlgvcJH4b/XZgjPHLIX7cpBHFpLps485Av8/6rtB1M7Hk94tBPlyWTEZJAPt3EhXVT0Y7h41G9Ot2prQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdIq19lQoD6y6taYyrgLroYs3L+MPDeGYhef4Sn4Ogg=;
 b=mXqH0OJJHCRpdfvNlILFPabj1aDM8WOlbYi8rWrFkWhc+VRxyHB9utgFYiqVw2p0qKK708VopUQA6DQkATMkI8JIAVuXz62IKKD0XO+DJL9oGGka1cfm4ybEn1nfjQH4r3q94Da5IOxGSd711XswECUUMnCaR1Lo3AkXrudrdsY=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 15:08:54 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:08:54 +0000
Date:   Tue, 15 Jun 2021 11:08:46 -0400
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
Message-ID: <20210615150846.GA409@aus-x-yghannam.amd.com>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMhwAZaFr4d1QOGG@zn.tnic>
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN0PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:408:eb::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN0PR04CA0163.namprd04.prod.outlook.com (2603:10b6:408:eb::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 15:08:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a02d827-965b-4346-8f80-08d9300f7d93
X-MS-TrafficTypeDiagnostic: BN8PR12MB3540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB35408CDE7D05F8FCB7CB1852F8309@BN8PR12MB3540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soDslirZFfBamFX7BtI4YLD/AghWtFQpOakfr/6+UWlF8gtPSR/EqsDkTKEYf6jAOr/VFvE2DQqSgixqHjD00Z128Ku0oYKRFBRQNEh3PSFw961izJ1NFoBDZ64eVgKwR37/PQrOvVuYphIF13xWLDj0NMAsx3XpnTsP5JOtaIOzM33SFcSy/fDQy5imuVR2raJq2IYQ3vcqQhQe9yboYU3P5uLdS1pjP6OQDm2s5a3obFldrX2yjTiN4eycKaI+zy0rro2cxQbJWZKxwn3BqDl20tiwLyuWCymEWmjIZI/YnuBTy5EO3lUKED1NEXYDy/ltIuth7SX2RbuQ0piBeqVYLtBgPVQIONiz+RLoqT99aWE1Svg+3jVLnMHV+kDMP7jxH6vFywE4Wkcc/+VYFwwDWlJMdRASd5AebSuwGbqVUAuxZ71TbxrZWdATXlgx5z7O5ghVTyKbD1YbZUG9ikPUoJtRmh0ae43kAarZtG3hSPFSBLlGdAN5yE7OzlN5UEzKbuaGgT6QNj7BTHiT248E/Uo77+X7NAjI9vLaioUnS8xRoZ+B6krjfBpmEx6cm18opBs6abV+NSTevth8JEpzaUyUN3bsjYcU5AZDQ1BUG1sj9BLzb6gM5ddk7mqh9lsGKASpsWyD6P8lhz0GiB1UM+ovRQLRjipEQruJEgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(6666004)(956004)(4326008)(66476007)(2906002)(33656002)(7696005)(478600001)(44832011)(66556008)(66946007)(52116002)(38350700002)(8676002)(55016002)(83380400001)(86362001)(6916009)(1076003)(186003)(16526019)(5660300002)(26005)(8936002)(316002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lq5dXphCNoq5Zs6htHXKqfGkytoUY0+MREsWRN1yq5BCHOfz51O2i37nq7k3?=
 =?us-ascii?Q?rQNZbDwesjf+IOiWJMhVnkK4dKTqWJKS37vmr/eYwfhIeJVUS+RQEY6JcwYA?=
 =?us-ascii?Q?6WnUgobxqNv7pq4JXRoksumdBw+/eNVIf+MrO+6Wt+9XVzWi3fAdxx8cJ/Mr?=
 =?us-ascii?Q?X5aljJMcEUTSqSUPbCxB3OCBqHBWcgdOEuJZufSO22YBHjr399ywZBej/cgB?=
 =?us-ascii?Q?Ea11Meafqvw4NUFMZedKvRVwZUgk5BSX5rgNLUJNNfs1U0hJ+Ic2ESH/Rh3X?=
 =?us-ascii?Q?4rp89N6FJEdvIx+xNHZOPeczUIs5eFarOxmTeHT5fcffaVX/nnL2zO7ZMKYQ?=
 =?us-ascii?Q?lGN7kN9GlFigeLifNiAgPcxkOXNfkr8kTmzY8z6p8jn/bM5X6tv0LtD10sOE?=
 =?us-ascii?Q?ExbJ0CheUMmZtMNpqhfHODeZ8MZi6a+iIcys4O31BSnZ2F7k5suedyR1SzmA?=
 =?us-ascii?Q?cqesoEXWy/JT1KJC/uyrsapaejYFmOeEhn1TelZ4Dv9fCXuWauuWcg9oztAv?=
 =?us-ascii?Q?hGlofvgpYdi3Jfnth/RvVjuFlR1GRH341s/Lf8zZXpv1COu1ojeJBESWzSlA?=
 =?us-ascii?Q?ge4gSQiX5I0a/lHYbedL3zoCET2M2V6WKA6VoIXZ/1Oy3X6KQNR3on+G7+k9?=
 =?us-ascii?Q?EkaCx6LAkdrpMD4Dx234QDhmUTaNJ5Gy3D7jdGQuFhrKBlZ3h/cBT4X1Nftk?=
 =?us-ascii?Q?zddZb2oAIWr76QDLkzpCH0iFHHKoaDrP9F9JpPKoh6BC7zqM8sjQo0LpisfS?=
 =?us-ascii?Q?CMsl9VcxzAIQ0aNlOuTDeNvhFDOr2gF/w3eDEfsAPo8I1BI9pa5xaArNf3Z4?=
 =?us-ascii?Q?ZW/BB0kUDVSxaGf+yKvEJCEhG1kuTR629bwd0y0LrNpli1q9NYiqFBD1wJrB?=
 =?us-ascii?Q?TF2uyu6/1LSeTRHsLExT7Y3UGnIcJdWAPgXlGn8IT2i+fF3TJkxIozvxUVLJ?=
 =?us-ascii?Q?iGu68fSeiGlJDhuz61UZXLIS+Ja7PhteZzoZI9yfVA8qkAGGgJAEVmxd9Rvq?=
 =?us-ascii?Q?RhdY32UEvdTYBQcBGAw3AMyLEnS+gd5DSUcm03Nkuiy67fafbYBp5XEKVjRf?=
 =?us-ascii?Q?Pkb17/L9mZqKVzWCZxxfkqJVuBWNr+LryjdR10oMlgGCp7LDtY0IIH4yMNnM?=
 =?us-ascii?Q?3TWujnW+W7JcVERw3+uarqqF9tIfB7I3dLLKZrN8jD4vh1bPR2f2M4NDWw1g?=
 =?us-ascii?Q?ovMq+4J+TsXOuVIySn8XG+LF5dVo1nM9Te9hTcPxi0LuxUVbLIao2fyIXZs7?=
 =?us-ascii?Q?SkW+7uHdXsC0QuPcv/Bf6ErL6THOBe7gDT7WDN5Ff6C0lGdZ1+WmNQ/iM04/?=
 =?us-ascii?Q?jqUssxy3XzNFPKTTq7hX6Kgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a02d827-965b-4346-8f80-08d9300f7d93
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:08:54.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQXLGaHgIdFtoF0KqIkFzB9licfOlnb61YSHBitnklhe0nj7DPMUNBIPSgxAaog8ZRIRun4UyTdozP+UMm23nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3540
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 11:16:49AM +0200, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 10:25:36PM +0000, Luck, Tony wrote:
> > I expect all the Intel EDAC drivers that load based on CPU model have similar
> > issues. Maybe they aren't whining as loudly about not being able to find the
> > memory controller devices?
> 
> Right.
> 
> > Though perhaps this is an issue outside of EDAC and x86_match_cpu()
> > could do the HYPERVISOR check and return no match. The few callers
> > who want to believe the fictional CPU model number passed in by the
> > VMM would need to use some new variant of the call?
> 
> Yeah, we could do
> 
> X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_NOT_FEATURE
> 
> notice the "NOT" and have a x86_cpu_id.not_feature which to match
> X86_FEATURE_HYPERVISOR. I'm not sure it is worth it, though, for a
> handful of drivers.
> 
> The whole thing is a meh, why bother, but I got tired of this particular
> intent of people wanting to shut this error message up just because they
> should not load that driver in a VM in the first place.
> 
> But what happens is they boot a guest with -cpu host and in that case
> that's a new CPU - family 0x19 - so it doesn't have a case 0x19 for the
> pr_warn_once() there.
> 
> And instead of keep adding adding families there, I'd simply check
> X86_FEATURE_HYPERVISOR.
> 
> Oh and that thing - mce_amd.c - doesn't use x86_match_cpu() so it has to
> be an explicit check on function entry.
>

How about adding the the SMCA feature to the amd64_cpuids[] table in
amd64_edac.c?

We can use X86_MATCH_VENDOR_FEATURE to match on AMD (and Hygon) systems
with SMCA. And we can remove the X86_MATCH_VENDOR_FAM entries for
families 17h-19h.

I'm assuming the issue is that amd64_edac_mod is autoloading due to the
family-based device table, and this will load edac_mce_amd as a
dependency.

Thanks,
Yazen


