Return-Path: <linux-edac+bounces-2720-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98CF9F2FE3
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 12:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED921888789
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB60204577;
	Mon, 16 Dec 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R7A4dX9P"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD0204579;
	Mon, 16 Dec 2024 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350180; cv=none; b=gbxBB4cteYX9TA7X1uPVVDQ5fKvggZW5TQydJSe4+1NkNYnGNNz+SrtIf4UVAW8ISe+VRphBmw21sVuJ6gpPCSjicFLxF6GWeWOKSFNeJZx/m6T9ROBT9VjObXqdYuTaK4/37UCtSFwpKRvi36S6Z4BBzqrOY1JYFFoxmobYAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350180; c=relaxed/simple;
	bh=OKPLTQHxIuUahfuatylu+8JAUqFjImAX8tPtEshEgDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejMuQMcJY91b/tGsZpRunHKh8EOl06AJ4M3ugFSVWIWhsr6Sidp/fN8xzbkumYAATLNBN3ev+yVt/5FRc62Nfc/jFsyU95FcGN+JsDzpYyjImHoszKeuE0E23azKGFCxSG63Mt6b/xNymmC93rH23C1my/yHO9bXHmz2F791gEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R7A4dX9P; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 400BD40E0266;
	Mon, 16 Dec 2024 11:56:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jl2PoPUHnDkL; Mon, 16 Dec 2024 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734350170; bh=rYh3Vo4Y6Cn3XYiD3KvUWwt/WV0Vv7KQwFCZjgxQ7rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7A4dX9P1IScVfb33XC4RQNy0URmuHQkdq5GjLGiEI0TQ5itVj5qopQ5swmf+3e4a
	 M9TGovU8mxakF3MnUrobGPUBnxnUm2WA5LdkrEMgyVOBEBcCyQQ5xucOFImQ+n3sza
	 7eZf2PH9fYnmAN6UIm7FDq1r912QcTsHLgb6nhi9wNwGgLX9Q1iWFHoitGyufh+FaI
	 OoQoyydcFJy/YF4+zLf08N0U7pTr6yktBnDLtkkyJc+svJs0stz1NSGkJjRqqhk8DR
	 N2tkkY6TrWISHOFiJEwpCP0eU/sotQNqzexbnzsXVtwIKoM0DvhPZXXfERBHcYsLSs
	 O++ZX6CvOocqtWuI1F8JvC00xUtrtko417tHLKNs0OJ1sz/lkLj8obn0ZdB7BZMsss
	 A7q3VpTxfHIt7HHEdvYjCSFPM/6Q5uZQ88q5dN3OYRbDm8ciIbHOiUiD27OIFa201y
	 o//CBl5yMwrAYwkV23IitIYNNy6zoj+hDNxJ3pGqaNuzOmYbFM09fDOWxUU0zIu7Vm
	 HDBLc8uHZxCdbl/OB3P6kIdauCniA23i2cJd32Mi7UPIneLChJwxGyo6T5sqa3WaQh
	 3i50lhOHT492p2Z2HrPTdIC9uuRP+sGXjZPu1ZloHYHVz4SOzmh9qXjv0YcNICvRa2
	 5Sd5VXOY6JV9YqOS+EfqgqAU=
Received: from zn.tnic (p200300ea971f937d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:937d:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1497140E0269;
	Mon, 16 Dec 2024 11:55:56 +0000 (UTC)
Date: Mon, 16 Dec 2024 12:55:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: chenhuacai@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@xen0n.name,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, loongarch@lists.linux.dev, xry111@xry111.site,
	Markus.Elfring@web.de, Jonathan.Cameron@huawei.com,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V10 RESEND] EDAC: Add EDAC driver for loongson memory
 controller
Message-ID: <20241216115546.GHZ2AVQi9u5lABWboE@fat_crate.local>
References: <20241216013351.15432-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216013351.15432-1-zhaoqunqin@loongson.cn>

On Mon, Dec 16, 2024 at 09:33:51AM +0800, Zhao Qunqin wrote:
> +LOONGSON EDAC DRIVER
> +M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
> +L:	linux-edac@vger.kernel.org
> +S:	Maintained
> +F:	drivers/edac/loongson_edac.c

If you add yourself as a maintainer, I'd expect you to review and/or ack
patches for your driver so that I can pick them up.

> +config EDAC_LOONGSON
> +	tristate "Loongson Memory Controller"
> +	depends on (LOONGARCH && ACPI) || COMPILE_TEST

The COMPILE_TEST thing would mean that you'll make sure this driver always
builds on other arches and it doesn't break randconfig builds of people. If it
happens too often and no one is fixing it, I'll remove the COMPILE_TEST.

> +	help
> +	  Support for error detection and correction on the Loongson
> +	  family memory controller. This driver reports single bit
> +	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
> +	  are compatible.
>  
>  endif # EDAC

> +static int read_ecc(struct mem_ctl_info *mci)
> +{
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +	u64 ecc;
> +	int cs;
> +
> +	if (!pvt->ecc_base)

When can that even happen? You're initializing it properly in pvt_init().

> +		return pvt->last_ce_count;
> +
> +	ecc = readq(pvt->ecc_base + ECC_CS_COUNT_REG);
> +	/* cs0 -- cs3 */
> +	cs = ecc & 0xff;
> +	cs += (ecc >> 8) & 0xff;
> +	cs += (ecc >> 16) & 0xff;
> +	cs += (ecc >> 24) & 0xff;
> +
> +	return cs;
> +}
> +
> +static void edac_check(struct mem_ctl_info *mci)
> +{
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +	int new, add;
> +
> +	new = read_ecc(mci);
> +	add = new - pvt->last_ce_count;
> +	pvt->last_ce_count = new;

That last_ce_count is just silly. Kill it.

> +	if (add <= 0)
> +		return;
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
> +			     0, 0, 0, 0, 0, -1, "error", "");
> +	edac_mc_printk(mci, KERN_INFO, "add: %d", add);

"add"? What are you adding? Error count?

No need.

> +static int edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_mc_layer layers[2];
> +	struct mem_ctl_info *mci;
> +	void __iomem *vbase;
> +	int ret;
> +
> +	vbase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(vbase))
> +		return PTR_ERR(vbase);
> +
> +	/* allocate a new MC control structure */
> +	layers[0].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = false;
> +	layers[1].type = EDAC_MC_LAYER_SLOT;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = true;
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct loongson_edac_pvt));
> +	if (mci == NULL)
> +		return -ENOMEM;
> +
> +	mci->mc_idx = edac_device_alloc_index();
> +	mci->mtype_cap = MEM_FLAG_RDDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE;
> +	mci->edac_cap = EDAC_FLAG_NONE;
> +	mci->mod_name = "loongson_edac.c";
> +	mci->ctl_name = "loongson_edac_ctl";
> +	mci->dev_name = "loongson_edac_dev";
> +	mci->ctl_page_to_phys = NULL;
> +	mci->pdev = &pdev->dev;
> +	mci->error_desc.grain = 8;
> +	/* Set the function pointer to an actual operation function */

Remove that obvious comment.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

