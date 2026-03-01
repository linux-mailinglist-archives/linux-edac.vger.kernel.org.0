Return-Path: <linux-edac+bounces-5758-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN9ANbFMpGkZdAUAu9opvQ
	(envelope-from <linux-edac+bounces-5758-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sun, 01 Mar 2026 15:26:57 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67A11D0349
	for <lists+linux-edac@lfdr.de>; Sun, 01 Mar 2026 15:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8416A300E3E8
	for <lists+linux-edac@lfdr.de>; Sun,  1 Mar 2026 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B0E33261F;
	Sun,  1 Mar 2026 14:26:54 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D201DF25F;
	Sun,  1 Mar 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772375214; cv=none; b=MtCdhRV8wKx6Sb7DvqHemIxYzGsN4GOmnurnfDjVVP0vU0D+DFkNJsaVACrlNakZ6B/aXvFT6avNAGOQ0FO6I3u3o89upQLyKROW1jnTKy4fHyKLvwumAgVj8kYPT4fRTVddzkPmV9uZ5C7TmKhUAAZBx7mXtRiksXa1+T4qanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772375214; c=relaxed/simple;
	bh=F+Lrguqjvo+Ws67IOH9ZnJn7oRV8+NdmAzcrK0Qf9ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J29irVNT3LYjP9wItipN0YVkIF1/X2gAaNoRLBP8zksSHc9HIWIl4LMK1areMOMNhbRofLPUfl//YprmCqAtrKrf7udmFpuGD4FiB5b3OFAW0hGjLVQ1rpnPNG/gNauK+K3sjWL6M6CyhV+BuIn+9IO2k77wHjpWKIzopiro4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shiaichun@open-hieco.net fp:SMTPD_---.gi-XiMx_1772375174 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 01 Mar 2026 22:26:43 +0800
From: Aichun Shi <shiaichun@open-hieco.net>
To: yazen.ghannam@amd.com
Cc: tglx@linutronix.de,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shiaichun@open-hieco.net
Subject: Re: [PATCH] EDAC/mce_amd: Fix Hygon UMC ECC error decoding with logical_die_id
Date: Sun,  1 Mar 2026 22:26:09 +0800
Message-ID: <20260301142609.242124-1-shiaichun@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260216203211.GB420258@yaz-khff2.amd.com>
References: <20260216203211.GB420258@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	DMARC_NA(0.00)[open-hieco.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5758-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.771];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	FROM_NEQ_ENVFROM(0.00)[shiaichun@open-hieco.net,linux-edac@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[open-hieco.net:mid,open-hieco.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B67A11D0349
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 03:32:11PM -0500, Yazen Ghannam wrote:
> On Sat, Feb 14, 2026 at 02:42:03PM +0800, Aichun Shi wrote:
> > cpuinfo_topology.amd_node_id is populated via CPUID or MSR, as introduced
> > by commit f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology
> > parser") and commit 03fa6bea5a3e ("x86/cpu: Make topology_amd_node_id()
> > use the actual node info"). However, this value may be non-continuous for
> > Hygon processors while EDAC uses continuous node IDs, which leads to
> > incorrect UMC ECC error decoding.
> 
> Can you please share an example?

Yazen, thanks for your reply!

Certainly. For example, on some Hygon processors with 2 sockets and 4 dies
per socket, amd_node_id is populated as 0,1,2,3 for the 4 dies on socket 0,
and 16,17,18,19 for the 4 dies on socket 1, which is non-contiguous.

> > 
> > In contract, cpuinfo_topology.logical_die_id always provides continuous
> > die (or node) IDs. Fix this by replacing topology_amd_node_id() with
> > topology_logical_die_id() when decoding UMC ECC errors for Hygon
> > processors.

On Hygon processors without CPUID leaf 0x80000026, the logical_die_id
obtained from topology_get_logical_id(apicid, TOPO_DIE_DOMAIN) is
incorrect. This is caused by the absence of die topology information
in the APIC ID space.

I have sent another patch to fix this issue:
https://lore.kernel.org/lkml/20260301141157.241770-1-shiaichun@open-hieco.net/
Could you help to review this patch firstly?

> > 
> > Signed-off-by: Aichun Shi <shiaichun@open-hieco.net>
> > ---
> >  drivers/edac/mce_amd.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> > index af3c12284a1e..4a23c1d6488e 100644
> > --- a/drivers/edac/mce_amd.c
> > +++ b/drivers/edac/mce_amd.c
> > @@ -746,8 +746,13 @@ static void decode_smca_error(struct mce *m)
> >  	pr_emerg(HW_ERR "%s Ext. Error Code: %d", smca_get_long_name(bank_type), xec);
> >  
> >  	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
> > -	    xec == 0 && decode_dram_ecc)
> > -		decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
> > +	    xec == 0 && decode_dram_ecc) {
> > +		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
> > +		    boot_cpu_data.x86 == 0x18)
> 
> Is the family check necessary? You did not mention a specific family in
> the commit message. So it seems the intent is to apply to all Hygon
> systems.

You are right, the family check (0x18) is over restrictive and can be removed.

> Thanks,
> Yazen

Thanks for your review and valuable comments!

Aichun Shi

