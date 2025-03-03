Return-Path: <linux-edac+bounces-3258-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056DA4CAB3
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 19:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8EB3B7C4C
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C42215F5C;
	Mon,  3 Mar 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VuXhDQ6e"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22C228CB7;
	Mon,  3 Mar 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024555; cv=none; b=hG90F4p0gldtB3Fh5wjVjXi7TlBsw/mDqObU7wJx3xqRHgJcLQHgSi/n1japiOjrgQq+rJw+/zCRwqN9fDT2bzgjJY+GwY1DijWJ7H9bhfXrKP7ZNs84QxS0rD39aicDHJRzZRXt7pDpYQIghCE5osnWmZYGWEh2yFAR5HF/9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024555; c=relaxed/simple;
	bh=FFa75hjKPxwn9nk90umMY5P1KnPLOGOOgrFEmMy74yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL+xwrUQTe7Yw/0EFiXiNMd0WniU2Cx8rHyswAa5OhJPjnbAwmC63fmYt4MvAIL+9GzqDl1BD4jfACQ2j8Zg6BSCyO5dT1G9M1R9NyLHpVlkCnuzA0uEGc86SuoAW64MTnieQ4u6F4QH2eoNMF8roOQTmMlxWSancruVrWdLHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VuXhDQ6e; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3EAFE40E0217;
	Mon,  3 Mar 2025 17:55:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F6NmxbeL5VQP; Mon,  3 Mar 2025 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741024545; bh=XR1jzLUSOCB344heFt8abZNteXZYan/jltUHuf6TFy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuXhDQ6e8gSDISmRMi7vKxncln2ZBZ2jdNiV4UEcJzJfxHyFLfw5OHFEiyX0EwlRJ
	 x1D3+4pBB2SkTLo1BKumpmkWxgS97HW09/ATz1AD7L/ZLU8Lnah+NUfC3TYbr7v0/w
	 VPCOK/aNvGVa6nZq09h3QzB9rocCGawhj6LnMakpjCisjOoTzG4JIfEL1cMHLaqVsa
	 cHMliDmIrmdLMkijhQ1eIK8fZmBFHRqd8Ba9IlEE+d0OpVaa5Pm18qfjZ6rroiecxy
	 MMtf7DEHjrG94HhdFve+h5zAUzyospP8xA2E28iW/vmnZxAPlNazvtmabbhakAdI+4
	 x46B5mkK08UUOfhgmFZP8u9m2VVKuqO+SM6nURgfab/7NaGdYSSNrmXOieR3o+15hH
	 zaCutAVMQbD4RmTmnzIuJcjp65GTxHmZtqHTT5G6+AiCd3WfdzMkrbL2HAFpB2ue+2
	 vaUXnn37L6g+UDAxK4X9N/E7HiZDZ80zvgi21u8QCDeVJOIvAWtgT5wTySFLnRxPQb
	 aDPQaNm8yXfy/VXrmqey46RbBMwhPqHRDbxccTIpZUGXOat2owZbfEaJ8CYx0fItvq
	 lefXFm7amm0Chn9koRm7YNJUj9GFmvno/FfDDLY5GXq+skyQjyJT8zSO4tk1I8fiBP
	 9yuCfDgSU3LjYsKniL9kW3bo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66C2C40E0215;
	Mon,  3 Mar 2025 17:55:33 +0000 (UTC)
Date: Mon, 3 Mar 2025 18:55:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v5 5/5] EDAC: Versal NET: Add support for error
 notification
Message-ID: <20250303175527.GDZ8XtD5pOTtLUe16B@fat_crate.local>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-6-shubhrajyoti.datta@amd.com>
 <20250211094002.GAZ6sa8l_2BdJQfk0I@fat_crate.local>
 <SA1PR12MB89472E1EF3BDE072EEEF17B181CD2@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB89472E1EF3BDE072EEEF17B181CD2@SA1PR12MB8947.namprd12.prod.outlook.com>

On Thu, Feb 27, 2025 at 11:32:10AM +0000, Datta, Shubhrajyoti wrote:
> > > +union edac_info {
> >
> > What is an "edac_info"?
> This is the row and column positions.
> We are using it to extract the position from the address decoder registers.

Needs a better name which is descriptive as to how it is used or what it
represents.

> > > +static void get_ddr_ue_error_info(u32 error_data[REGS_PER_CONTROLLER],
> > struct edac_priv *priv)
> >                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > What is that for?
> >
> The error_data contains the register values. Linux does not have access to the DDRMC register
> Space. It queries it from the NMC and gets the the data from the rpmsg callback.

I wasn't clear. Arrays in C are passed as pointers - the compiler does that
anyway.  You don't have to do this weird parameter specification.

> > > +     mci->edac_cap = EDAC_FLAG_SECDED;
> > > +     mci->ctl_name = "amd_ddr_controller";
> > > +     mci->dev_name = dev_name(&pdev->dev);
> > > +     mci->mod_name = "amd_edac";
> >
> > Do:
> >
> > git grep mod_name drivers/edac/
> >
> > to get an idea how those names are chosen.
> #define EDAC_MOD_STR    "r82600_edac"
> mci->mod_name = EDAC_MOD_STR;
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/edac/r82600_edac.c?h=v6.14-rc4#n316
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/edac/i5000_edac.c?h=v6.14-rc4#n1424
> mci->mod_name = "i5000_edac.c";
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/edac/highbank_mc_edac.c?h=v6.14-rc4#n218
> mci->mod_name = pdev->dev.driver->name;
> 
> let me know if mci->mod_name = pdev->dev.driver->name; is fine.

I think you didn't get me again.

amd64_edac.c - the x86 driver is called this:

#define EDAC_MOD_STR "amd64_edac"

Calling yours "amd_edac" doesn't work.

"versalnet_edac"? That's probably better.

> > You don't need "inline" - the compiler can decide that itself. And
> > "process_bit" needs a better name.
> 
> Will rename it to populate_row_bit

Or "assign_row_bit" or whatever.

The function name should be describing what the function does as closely as
possible.

> > Why are those functions copying stuff around? Why aren't you using cols
> > directly?
> 
> The column bit position is used in converting to the physical address.
> We read it at init and use it every time an error occurs to get the address.
> Did you mean to remove the regval. Or read the error_data every time.

I mean simply use cols instead of assigning stuff to priv->col_bit* and then
using that.

> > Why is probing a work item?
> >
> > Explaining *that* is what a commit message is for - not for repeating useless
> > info.
> The RPMsg probe is invoked from a thread within the virtio driver responsible
> for processing the response ring. If the probe initiates an mcdi API call, it blocks
> until the mcdi response is received. However, since the mcdi response is also processed
> by the same thread that triggered the rpmsg probe, the thread remains blocked,
> preventing it from handling the response. This results in a deadlock.
> 
> To prevent it we have a work scheduled.

This is just insane.

I don't see anything in amd_setup_mcdi() that needs some response from some
mcdi thing. If not, you don't need the work queue thing.

> >
> > > +     for (i = 0; i < NUM_CONTROLLERS; i++) {
> > > +             config = priv->adec[CONF + i];
> > > +             num_chans = FIELD_GET(DDRMC5_NUM_CHANS_MASK, config);
> > > +             rank = FIELD_GET(DDRMC5_RANK_MASK, config);
> > > +             rank = 1 << rank;
> > > +             dwidth = FIELD_GET(DDRMC5_BUS_WIDTH_MASK, config);
> > > +             dt = get_dwidth(dwidth);
> > > +             if (dt != DEV_UNKNOWN)
> > > +                     break;
> > > +     }
> >
> > What is that loop supposed to do? Find the last controller before the one
> > with DEV_UNKNOWN device width and register that one?
> 
> There are 8 controllers all we try to get the first one that is enabled and register that one.
> We use the device unknown to know if that is enabled or not.

The first one that is enabled has unknown device width? What?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

