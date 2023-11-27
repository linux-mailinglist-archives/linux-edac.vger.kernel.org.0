Return-Path: <linux-edac+bounces-98-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAF7F9EE5
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22822B20FD0
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539161A711;
	Mon, 27 Nov 2023 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T39uneXW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6DB8;
	Mon, 27 Nov 2023 03:47:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 09DAC40E0031;
	Mon, 27 Nov 2023 11:47:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x6hZ-EGEfnLs; Mon, 27 Nov 2023 11:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1701085618; bh=/FKxTv6AjjlU5bbOmJK6+9TUZ7Du5ZJJm4TeskqqvDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T39uneXWDF1Ayh/26hwFQzyFylzQq/fGYQ/pZjE00drc8L7ewUtywddk4NmZ9+G2A
	 cNMQFZiDoQpkBXYr+9ueP3XqABPv9su1UtpUOHHvL8x42KVfJrmeP+TV5+Ybg9ohjU
	 EWdgBy/agDBhfapaexE1uPpNZTYGB+0NLO1Sjfjtu/8Hm7KZBECRSIJMzmzjbPbtka
	 6MhmlWMZ3jhL9Cpx6miF+9TGH6huE27f7v9GJL0AtWafiObEQn7ANa9giWiNhAH19I
	 z0vKen3cnNx5A4BzGf+TM480djipEgzF0SABapRFCVrx7Z2HqpljI/KCSp7bRkEhxo
	 6znRyGB2W/nurt4gEYaP+sENYbqiNfZ8UZ5VpOLWEM3AOWHI67gU8GeuNkVwsWvQS5
	 YVmZaZXJZoM+CzLYWynQMPLiz/Homj7kOD28BDcrc7Ww1rqtbVttoZZ6CiHV48oeU8
	 zcihij6RTcC/GRJzyHeHhRAp6M5f76iCH9s9S2thrxsb9hJqOW6JwgNuqH3BfzVMEU
	 tsco5ZYMeMd0OdtVMpJFAR43wM0bYGrexqmpmrXh/yi7rvamuM9TZeOUdBwHED9eBU
	 vePzmB65Bc/N0JiwW/xkVyEB4IUNyFZ2lOzIupQTJdNqwlQqru8mms+6DoYLYFSorF
	 qmsF3LvP7Jsn0wAYCCIPe72k=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D8A540E014B;
	Mon, 27 Nov 2023 11:46:49 +0000 (UTC)
Date: Mon, 27 Nov 2023 12:46:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	Smita.KoralahalliChannabasappa@amd.com,
	amd-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] x86/mce/amd: Use helper for GPU UMC bank type
 checks
Message-ID: <20231127114648.GNZWSBqPq3AzQkwk+S@fat_crate.local>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-7-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231118193248.1296798-7-yazen.ghannam@amd.com>

On Sat, Nov 18, 2023 at 01:32:34PM -0600, Yazen Ghannam wrote:
> +/* GPU UMCs have MCATYPE=0x1.*/
> +bool smca_gpu_umc_bank_type(u64 ipid)
> +{
> +	if (!smca_umc_bank_type(ipid))
> +		return false;
> +
> +	return FIELD_GET(MCI_IPID_MCATYPE, ipid) == 0x1;
> +}

And now this tells you that you want to use

	u32 hwid_mcatype;       /* (hwid,mcatype) tuple */

everywhere and do your macros around that thing.

No need for yet another helper as this all is static information which
doesn't change.

> +EXPORT_SYMBOL_GPL(smca_gpu_umc_bank_type);

Definitely not another export.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

