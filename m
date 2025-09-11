Return-Path: <linux-edac+bounces-4795-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFFDB5384A
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D947A60DC
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301793431F1;
	Thu, 11 Sep 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ziZtw1Ju"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81507261B83;
	Thu, 11 Sep 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606007; cv=fail; b=GN6Dj6akoceI+D5b62Wh9F2tlRab3VoAux3JYlqLO1S68GvlCv4xaRS7huXB2gAulH0zkyUKR4LltQlrG/eylFdMofl0F3hsnxYeHQDZQxAG4qm5F4hhPEUZeOgCfgo+gfoKp4YhND/e9tFXiUvEG6WeqzQf55HAREXkCCgP3MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606007; c=relaxed/simple;
	bh=0PbXaodvUBVzjx+1fI/43yA3a0A6f3sMDd19UBfOd1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JzHQLev4qEjNiwfCkz4fzPruV9zBCXMySTXUw7zDexeV3s6XLvzP2EEtRz61Hus/F4zNNbe5LYdcn8GuiFwp5HnBON4BdUFrFgkpbVTc9d1SujF7uWX7HnTW3XZre/bJI/koxGFqa7KiQqp0rvZuTMHJkK7rfRJmCNSg3NCaCk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ziZtw1Ju; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip5gJHS7PWBTHH9OoiI4T7ilLtdukEtSFjKISwTbiKM0exB3dWQspFTLr5QOuW3b+xMZJptQTiN9xRpvfz/+13YHaSsW0tilklBzuUdq38bYZc19YSLMI8VTI3Koo6aLiOwG+pA648XeXnBUX+/HPyg1Tv+FoVO/brsidkKUBYVqN8IL03mcAGYTwi0h0WTwAiWO/OoxAaFamYIiVpkiS7dOzLv80DZSkhFCoT3DwTQF3UlpRaqdtVIRsKbGIpgVDa6jE3il3GpGMrUixedWJh3O/ugb0Ie3/Q5DwBrPcUINlQ6lXvT7qpTXg0oTmXsFb/CZJnogehNQjwiaD95AGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r81oeZrTJ4ncYTZcv/w45CYyx+1xnD5E5ocEAmByxeY=;
 b=qHrKZSNE7B1lprFzREQCiiQWtB+y3qDcn5TYHWiqBT0yOkXgi6L4PJ2j79q8I0gGJ6v/KDC5CGiReYpnTLbUvG0S6VwkznSmdfE3CaRaVGsDRdFdNBW5jh/fyyBkFH9n8anSMzgteop8Fnm+YPMwS85fodWz3+Vd6gchH+KXwveTfy3IcUadPQ/2fe7ovOlHL9qh0HaaUV3QmSraKqKfTt/E/381/4UQf8kSVHJJJj/1FXjhspnFNpHlnX09gGgKxuYZYNn/7NLcHWw3M8XdPV6dV+/4938rfqWJyGEzP5P8yfvT9mW9YvMTqWi9F+dQTRX+KeJGvQ1PVt0UAZhtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r81oeZrTJ4ncYTZcv/w45CYyx+1xnD5E5ocEAmByxeY=;
 b=ziZtw1JuavhvhzAB7aiclzDIKG0ZFizeOXdfmXKHVf8Bh/q8l5mgCb7WcDtvSLo4L9xyqjmBgkByIGp2umN5QomPnINK8t1jkC5QPTFPXxXmFSOp/uCHvzdPPMYFQC5bCPFOV+WdxvLaEV3lSerttzUG2q4DHOpvwZDtdfJohs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:53:22 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:53:21 +0000
Date: Thu, 11 Sep 2025 11:53:14 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 10/15] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250911155314.GA108087@yaz-khff2.amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-10-eef5d6c74b9c@amd.com>
 <d5377e66-dbbc-4883-b223-ef6c0360e0dd@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5377e66-dbbc-4883-b223-ef6c0360e0dd@suse.com>
X-ClientProxiedBy: BN0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:408:e5::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 86079f10-a86b-41ef-d411-08ddf14b544c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l1i2yw3/sgE14r8IeE1Ytonn+3jJ/Trxkn0REZtaYV5rEd0mCPtNRUZJbFxM?=
 =?us-ascii?Q?TaDUv3k4e3usK1aCayrA5OkWPhXMTCYZtCi+oHORL701p6e4gq8jDZQzRS9d?=
 =?us-ascii?Q?lOntUznC0OoNwY88xBYfYRinbfCFzyTIgAkwd7VpbrBKkmKXQoy0wBdRhAnV?=
 =?us-ascii?Q?42xalg9E/My+f+ofknnjcDXbhNiSL/tcbomdg69LCI/AD0ig2OfbwKtM1Cy3?=
 =?us-ascii?Q?ytmFKdo/DGuIriAN/3zCdDcj60ZmeILI73NOBinjkBYUx1maoWU4TZAT9Awr?=
 =?us-ascii?Q?e0HqX5BccSEA9dY3mDf1+e1YOGVat/217Uf2AX2CFwoqp0fLdV11GIiN/rMk?=
 =?us-ascii?Q?8HZDavmOj3Jwgz9kR/B/DuZXJQ3/K3p12rws13XiK5OWYReCQIl/fIthURr6?=
 =?us-ascii?Q?nmk2JUjfuP786+GODQOvkoez1pyQV2YXC+vGUU4hsk8lD+BXQa55H60kTqeU?=
 =?us-ascii?Q?d8kUlcay/uaHDYxCdR1NnqVgfazRkEvn2KLyhxVkEyr4qaqLq8MuUlnxbFJ+?=
 =?us-ascii?Q?FZqDkDxKX03jh6gozE5+V92ZIBOSRI35AyTh1hrxscIqWIi2dQ9T2AyFkWz+?=
 =?us-ascii?Q?JfSqS1r7Jr9KPxrXGsDChIYjRGe3eZnd2JVX1L+bnlJpvANIg4oaq+B5BDPo?=
 =?us-ascii?Q?jKq1Q0+K9mRYE6akAit4Yj/F/pLxlwUbNjoq6up7oauaM1GTc2/O0uwf/6sj?=
 =?us-ascii?Q?nAaCoSUrfSBuPEYlwRm43BZJ6gQH/2J72n5CTL84bIdibIKpYwLoPnSqyf/f?=
 =?us-ascii?Q?HtvIZY5dshfxkOtKi7HDeb07c2DGsMP3HXW5GQmnw9ByEX8ZH9AmqzprnICo?=
 =?us-ascii?Q?/tpzqk+YvNVPR09ZKL+unJRBlZAM/PeH7uFmqTNaopXzq+OxRoQHrU4MCdWF?=
 =?us-ascii?Q?F6n8Mj2oTWNn2GKSFhXIlX5LGnpLuv7Mk+fArbvh6/1mCNftvbnpjfD1gALZ?=
 =?us-ascii?Q?/+Pswre1n8wQe/dYZcY/OJUiJ3wK2w3wyzDHzxRTFb2FC4Cd8S36ph21mZBx?=
 =?us-ascii?Q?usdfkmMo1xpOc/OugR7Bz5WC2fbKugPTFKLLxNBzCoF29igp2vE4HL7up5Dm?=
 =?us-ascii?Q?YbZ34SttgkPhlnpZqlSCcW3JDUD0MbML0qIHQ3DYV5xxxsgwfi6B4NAsPjL6?=
 =?us-ascii?Q?lvARvfpPofLJgNMh4ldR8PbVO2HModDOuBSVWC2rpiTUieXsQwIzqG9ttTw6?=
 =?us-ascii?Q?Qr9eXTFZi8aRi2auJSGaUoeUUmJvxtauQqiqXMb9f3TO1Q7/BQs47Gw8z0By?=
 =?us-ascii?Q?9YNBVB9+eTMNeIiWr/OjWT3rt09sRIMNGZDAonyygOLUK3OWilLKxl9sBQ2v?=
 =?us-ascii?Q?DdsgVwdrKGQjcE9rVC4kTjgC9+eftkOrvRoZsMYvEUEhUCsLmpuOiZGtdC85?=
 =?us-ascii?Q?VyHUwyPyChO0H37ynHA390mT3sMLTpuyrKB07+tqHFhlQ4s63qG+GQet815v?=
 =?us-ascii?Q?zWiLOhsxYY703XNC7errfJX9iXUK8LQV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0QOgKlFVAE7GUZ5rvVans1e4y1Cx+PTurXUYImnaIXnKff3jPJ4YXXmD+PK?=
 =?us-ascii?Q?F1+nloaY8CLfqow+OZW6DRKFeUGZ8AwyIMre4NW6fYZOisl5qKL8WHlv42l3?=
 =?us-ascii?Q?NetGcRlnMgDpBjiiODJhMQn4RRcJXC8IP9zPAu2zD4FCNUte7m+1m/r7jBZz?=
 =?us-ascii?Q?fUzh0PHaN26VI20bgbtJ0VHWmqS5cDHiLjM+xYUg+0F/Bc5v4aq1FHPOv1A9?=
 =?us-ascii?Q?yGF3tPCiq9RZp0aiISvxtiJO7pn0nlPlGz7/SAKuCM41i5imXeeqUuwNFlVl?=
 =?us-ascii?Q?YD+SyU1tJpBxLkryS0YLSX+hYGB2W40e4Fln5zQGURU1X0apEVwe7nzFPAXF?=
 =?us-ascii?Q?mCvFotCwBCvWyS4wyNBOYH2VGgt5DJit73941Xt4L5oEg3nmTa+Y8peZGqQH?=
 =?us-ascii?Q?iSGAQ09JhSMRQ/4NiQJlXkdHDYTTOUP3sv3npRF5Qh65lEN+sx5XYY+EEEoO?=
 =?us-ascii?Q?qHXuDP2bTtDUDxCu8Ihslebs77QkSZejWy66dN/qlsTJvET8HQHWLISowpgn?=
 =?us-ascii?Q?MzOrmCEDBX9mVCU5zn8nWU+VzgPMwYUL+lcpnLwhzWv4JpjpfipXqfNYwHt5?=
 =?us-ascii?Q?V128DxhrEWdLe8Mxtu4+wdrjWD2eO3+G6AJrfHzOBTumSHgNF+D5KuDzZcZM?=
 =?us-ascii?Q?6U6AnaYLQF9dIN3ZsQIYcBESq2R/f+oJVTzVUF3tetiXcgwknKMnFsDNxu75?=
 =?us-ascii?Q?hYK+vmSU8YetPuOegKyKKp//7bj/drA3o5htDPzTTFUwNNopz/HmmOU09kJd?=
 =?us-ascii?Q?P7mJM6KMPGM8LAr6itCwA3mOc7at/Iusitjjq8uydhSn/Y0StfbdeZZEVodt?=
 =?us-ascii?Q?aZT2BSz8sBGUZPGrHMSrdwxUfqKqZBgda7OynaZFntY4N1xj1oxSl02WsTeV?=
 =?us-ascii?Q?OBSWjv3iVx5vtZEi7ATA2eTNngjQzD0t3/pwkzXViVTfiSjEiPD9ixpBwJNw?=
 =?us-ascii?Q?TN5uN8gX/yRJgVZbfc4GZ6itdrkVGYGxJvQmrITZ+Eh9dYqUfWCPudC2qqIR?=
 =?us-ascii?Q?x2PbiKvAFpzJ8+vwmxNeKNQ5N9F7T4/OOR2XyNNX2E6wqJbJeUrIclC36opR?=
 =?us-ascii?Q?VWzzKvaRfiwBr0Z7+OBiymnvWfxo1wW/bcZxmUcT+nMpmgK0/G2Q9ZyzOGsh?=
 =?us-ascii?Q?+SQMVIKq4YdowJCnN9bb3gzL0Sj/ZQI1elA1+88Wb5Mwgj0T/p84yNzXKHWC?=
 =?us-ascii?Q?2JYJaUcPjOnbJrDvct8DUEoj4oG5v/xmlxfDc2sUBI91IDuhElFmKmaCqmSW?=
 =?us-ascii?Q?+Q8dAkeKNOW0hc1ZxgxZu7k1n48U+qgdzgkasGvJsbOkWwEkimLGsLpFI5jV?=
 =?us-ascii?Q?SOOG4bi7kpa32f8EtVdZlRTc9pBbCJSn8GbF8zmYbZJPhkRAE16JxFPplfmk?=
 =?us-ascii?Q?c10+AJSN4BbQuMcnjCeQVzwlCVt1cgfJ8uHlpx3B1cVlrU65kGVgfgiukDJm?=
 =?us-ascii?Q?Lud2Jc6WPwOg9cSBelYOt3vIfalMYa8attNyBpb50igEaqHpjjwP3x2HKYwJ?=
 =?us-ascii?Q?k1OXaUdHoJ6U1q7UF1iCzXIYZwj4Y3D/NCQip82Ek5ojIvmQilEKYGxl2jUC?=
 =?us-ascii?Q?4jYKSmCD+HTi7UcrASZFTgOYZUT9+hMcq6jr9xGz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86079f10-a86b-41ef-d411-08ddf14b544c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:53:21.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRODD4LcwJpjhFrxfMEzH0H0M20U/zGpT0CXLG5mLCki41bMqRRvWsERVfiRBG2VzylAwxWoobTERY4Vw0xQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

On Thu, Sep 11, 2025 at 01:22:10PM +0300, Nikolay Borisov wrote:
> 
> 
> On 9/8/25 18:40, Yazen Ghannam wrote:
> > Scalable MCA systems have a per-CPU register that gives the APIC LVT
> > offset for the thresholding and deferred error interrupts.
> > 
> > Currently, this register is read once to set up the deferred error
> > interrupt and then read again for each thresholding block. Furthermore,
> > the APIC LVT registers are configured each time, but they only need to
> > be configured once per-CPU.
> > 
> > Move the APIC LVT setup to the early part of CPU init, so that the
> > registers are set up once. Also, this ensures that the kernel is ready
> > to service the interrupts before the individual error sources (each MCA
> > bank) are enabled.
> > 
> > Apply this change only to SMCA systems to avoid breaking any legacy
> > behavior. The deferred error interrupt is technically advertised by the
> > SUCCOR feature. However, this was first made available on SMCA systems.
> > Therefore, only set up the deferred error interrupt on SMCA systems and
> > simplify the code.
> > 
> > Guidance from hardware designers is that the LVT offsets provided from
> > the platform should be used. The kernel should not try to enforce
> > specific values. However, the kernel should check that an LVT offset is
> > not reused for multiple sources.
> > 
> > Therefore, remove the extra checking and value enforcement from the MCE
> > code. The "reuse/conflict" case is already handled in
> > setup_APIC_eilvt().
> > 
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > 
> > Notes:
> >      Link:
> >      https://lore.kernel.org/r/20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com
> >      v5->v6:
> >      * Applied "bools to flags" and other fixups from Boris.
> >      v4->v5:
> >      * Added back to set.
> >      * Updated commit message with more details.
> >      v3->v4:
> >      * Dropped from set.
> >      v2->v3:
> >      * Add tags from Tony.
> >      v1->v2:
> >      * Use new per-CPU struct.
> >      * Don't set up interrupt vectors.
> > 
> >   arch/x86/kernel/cpu/mce/amd.c | 121 ++++++++++++++++++------------------------
> >   1 file changed, 53 insertions(+), 68 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index 1b1b83b3aef9..a6f5c9339d7c 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -43,9 +43,6 @@
> >   /* Deferred error settings */
> >   #define MSR_CU_DEF_ERR		0xC0000410
> 
> nit: While touching this code why not finally rename this in line with the
> APM, section 9.3.1.4: MCA_INTR_CFG
> 
> Perhaps as a separate patch. I see that you did send a patch containing this
> rename:
> https://lore.kernel.org/all/20231118193248.1296798-13-yazen.ghannam@amd.com/
> But I guess it didn't land.

Yep, thanks for noticing. :)

IIRC, I tried to reduce this set down to (mostly) functional changes.

I think that there is still more worthwhile refactoring to do.

Thanks,
Yazen

