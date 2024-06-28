Return-Path: <linux-edac+bounces-1427-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F13DB91B8B9
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 09:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26808B21292
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43E1142E88;
	Fri, 28 Jun 2024 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T15y8IUk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA925C89;
	Fri, 28 Jun 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560711; cv=none; b=nCIEYye7WbS+fr+7YMJAEJPZGv7B8uEGiola2kJLLIaWtM6UsB5cWGN53vTq5esEpfstlAGcwq9q2+I+EHR95kSlfD2Dd7uVotlezXULNh1g9RctzRp1aNM+wyzUcEbY6p4n7KyPVOqRGrACILPKbw2YnCDYY92YPtLVn8QfZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560711; c=relaxed/simple;
	bh=p0jV8ElzLovC8PJpEjbIBYA1mtu9/RdPJD4TfKMl0XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6L0FvJ6wxVjTw2+7pMluzV/gM9M+1roYPEMvsGm1BWQJ0OvBS6edai/FLTyc0WZlEsRxlmAYN+WHK94uN7jZEzpFfuF6zqHmvZYDR8XM28eNNCce24w/qzTeaKmE3pfAgDy9UeDotBKDCn/UWRXeUPXfMWmoBbf6pxiSbSM0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T15y8IUk reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F07A140E0192;
	Fri, 28 Jun 2024 07:45:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sSMyDzu3hfvb; Fri, 28 Jun 2024 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719560702; bh=7ldIwKtvzJ9yyJaNutYVVLJe0u6aE/RpeHC5fXaXUi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T15y8IUk+bsQfYjGmcY6To0pwblhcpGHNswc+3j5JXhvAbRzNuPlqQSefH/AHnwCc
	 eOMQextITsSwFSnuTNoE9ab/AKH1XQn/07Y25ZVWhUisN6nzF7/LwFFb/eSuOSUxOe
	 e8/I1A91o32iVgoTaRyjnNmIqNW1NRiathWQAr5S/njI/LQEgxrRrFBqgnd9yT5OSq
	 92CkTxXPPdPY4E8pwZohAFPu1rEQE/pvgCyptIHRXVIlJDe6G6mqW/87VUvDVIKb7J
	 qj0LrRfo3Fod96P3U0aDYzK9H0SdH90izxcANNjyDdXOwmo25pfDqUC4jNrLczlwpQ
	 2smMW5CWnky12/0duRZKbNiQvj7vTrA6cM/xtJBNv3YLJaIRqkZLSTI3C/QLjiDdLA
	 JeLJIhCYWHrxCWVNr/F6KlbGUIEzL4UsuCUESovO1GQ0bgYtUPSgS52SjZzltvvU+D
	 AYbw7wvJsnHv/9UN8GjUzPSqDB/NJHZs2UAyEbkYE1hZQSVopJ526hncioN2IDsFNN
	 xzkXkGijGLzCq3+SjZwJDCeBkZuvOvQxIUczCy5zRhIsRt57hL6r4jnmJyGlAfmT8+
	 M459T/gYSYKXbnif4ygRocX5If+eZoqGGJeUR18T0vAuvQ2cWnmHjCim6x4GvncNGT
	 r5KcbGjeg1Wf22a5cNHvvm3w=
Received: from nazgul.tnic (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FB9340E021A;
	Fri, 28 Jun 2024 07:44:55 +0000 (UTC)
Date: Fri, 28 Jun 2024 09:45:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system
 physical addresses using PRM
Message-ID: <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-3-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506174721.72018-3-john.allen@amd.com>
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 05:47:21PM +0000, John Allen wrote:
> Future AMD platforms will provide a UEFI PRM module that implements a
> number of address translation PRM handlers. This will provide an
> interface for the OS to call platform specific code without requiring
> the use of SMM or other heavy firmware operations.
>=20
> AMD Zen-based systems report memory error addresses through Machine
> Check banks representing Unified Memory Controllers (UMCs) in the form
> of UMC relative "normalized" addresses. A normalized address must be
> converted to a system physical address to be usable by the OS.

This should be your first paragraph.

> Add support for the normalized to system physical address translation
> PRM handler in the AMD Address Translation Library and prefer it over
> native code if available. The GUID and parameter buffer structure are
> specific to the normalized to system physical address handler provided
> by the address translation PRM module included in future AMD systems.
>=20
> The address translation PRM module is documented in chapter 22 of the
> publicly available "AMD Family 1Ah Models 00h=E2=80=930Fh and Models 10=
h=E2=80=931Fh
> ACPI v6.5 Porting Guide":
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/pr=
ogrammer-references/58088-0.75-pub.pdf

Those URLs are flaky and become invalid over time. When you quote
a document, quote it in such a way so that searching for it on the web,
can find it. The name above works for me so that's good.

> +#include "internal.h"
> +
> +#if defined(CONFIG_ACPI_PRMT)

Instead of that ifdeffery you could do:

config AMD_ATL_PRM
	depends on AMD_ATL && ACPI_PRMT

and it'll get enabled automatically and then you don't need the empty
stub either.

> +#include <linux/prmt.h>
> +
> +struct prm_umc_param_buffer_norm {

What's a prm_umc_param_buffer_norm?

> +	u64 norm_addr;
> +	u8 socket;
> +	u64 umc_bank_inst_id;
> +	void *output_buffer;

Use the usual short versions for such standard names: "out_buf"

> +} __packed;
> +
> +static const guid_t norm_to_sys_prm_handler_guid =3D GUID_INIT(0xE7180=
659, 0xA65D,
> +							     0x451D, 0x92, 0xCD,
> +							     0x2B, 0x56, 0xF1, 0x2B,
> +							     0xEB, 0xA6);

When you define such long variable names, your lines stick out
unnecessarily. Shorten pls.

> +unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst=
_id, unsigned long addr)

bank_id is fine.

> +{
> +	struct prm_umc_param_buffer_norm param_buffer;

... p_buf;

> +	unsigned long ret_addr;
> +	int ret;
> +
> +	param_buffer.norm_addr        =3D addr;
> +	param_buffer.socket           =3D socket_id;
> +	param_buffer.umc_bank_inst_id =3D umc_bank_inst_id;
> +	param_buffer.output_buffer    =3D &ret_addr;
> +
> +	ret =3D acpi_call_prm_handler(norm_to_sys_prm_handler_guid, &param_bu=
ffer);
> +	if (!ret)
> +		return ret_addr;
> +
> +	if (ret =3D=3D -ENODEV)
> +		pr_debug("PRM module/handler not available\n");
> +	else
> +		pr_notice_once("PRM address translation failed\n");
> +
> +	return ret;
> +}

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

