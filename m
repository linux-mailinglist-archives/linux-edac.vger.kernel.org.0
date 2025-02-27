Return-Path: <linux-edac+bounces-3222-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA2A48A17
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 21:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC38188FA10
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229422D4CD;
	Thu, 27 Feb 2025 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FKkN3q9v"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9391AF0C9;
	Thu, 27 Feb 2025 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689303; cv=none; b=KQUDGe42m2St1AzfGFJibPb5MtdOD9RxCs8fLxMaqEqNxDfWKMtkZEY0ZHsC9ZjH70ZVqAj/R2wm6oRNyhYvkHE6QY+FYymH4EaBFP8GFq/3IERIpSbzu8n6Sbj4WgbAfg+pwtg4YLcmUi4fO0upNpYJoEAjp6QqWy1+4U47JwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689303; c=relaxed/simple;
	bh=E6vjaBz8GluSuB4mgoO/H4qAMkQzsqIUytDC2yfntdg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VB/HXortfa4w4GMBSYvUyYrH0yRF4G3JLiLcBrMbnt00BYzAY9HgM7int4s9JWWwOtHIha4q7jzu+n1vbL4VzkgN8/6Ql9O4fylmOs0buCzmqlRUJaRGKuLH02S2NOkGFlh8FGGU7qeBOwrLIg4YeyK/tWtmAHMxoLxmOQqncCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FKkN3q9v; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4358E40E0202;
	Thu, 27 Feb 2025 20:48:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mV4CUirKJE3p; Thu, 27 Feb 2025 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740689291; bh=L7HiZKIxRCTs4Kcv2wAxMWKLoQxNiMilxiOAZTJGudA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FKkN3q9vAGnWvHH428XdiS8/qL5hKhzaYZ/HOJc2oNVZ1ua571fZ1lQQhebMRYOJQ
	 xQAwaF2xglljH8B04dWSRzheneb+oDnp8dhFMOjXtaIblAkxOHmPbhjAnDtbLqMpeP
	 9pF9CWgu7B9sDGvePzMN5sSzxdF5j/HB3g6ezFBiXM8l1NXOiVtkQhyxWQalNqmydW
	 Ke2r656u5wFDLAKaGQz2AfY+GLQSxsVV6/mYNv2USkmgSs6UBmKa/vVXA6PmpdFrEu
	 QN88mGWbdD8ew4FJTUcEJLfTBjsqzhckmcHai9tV9fUBEA+dvg8Meaqs/4De27sjhz
	 w3adp2BovXAX1kp+Fp2jtY+bKCACIUxHZ/bpco809QJdiSAAPiTXplHkLG9EgO2toF
	 F52MtPVew5BFUK919d5BlO4EIxR9r9++5ofCe1sLoyzIZGq46zc4930XDnfjewa/7/
	 Y0jIK9GV9tEd+07jzRLh+vHQM3FdbB8ZDENONjlKeMTu1VDXOesbSAxZOamE6JFBfF
	 N+jAnyoJh892jYd+CNoTwhkN9E7WKbjkfFxIOVWxALTxW0pz7fiXlFIxoxit/dBIrp
	 R9CynF5dgsQhIiXr3tyrUxOLa0bT6IZSTaAoMdnhuIXDcpx+fdrXJjONOXrc5GjoU4
	 wX0vcZC8haCztGTrVT5g+UM4=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3033:266:d506:45ad:ba23:3ebb:9784])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B17A840E01A1;
	Thu, 27 Feb 2025 20:48:05 +0000 (UTC)
Date: Thu, 27 Feb 2025 21:48:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: x86@kernel.org, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250227195933.GA936031@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com> <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com> <20250227152500.GAZ8CDzEBRWBUukmcl@fat_crate.local> <20250227163148.GA785742@yaz-khff2.amd.com> <DE184F9D-EF80-4A88-9275-C900C4AA13D2@alien8.de> <20250227195933.GA936031@yaz-khff2.amd.com>
Message-ID: <7D626975-3F9C-4B7F-A1E7-FAB3B02964DC@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 27, 2025 8:59:33 PM GMT+01:00, Yazen Ghannam <yazen=2Eghannam@a=
md=2Ecom> wrote:
>On Thu, Feb 27, 2025 at 08:33:19PM +0100, Borislav Petkov wrote:
>> On February 27, 2025 5:31:48 PM GMT+01:00, Yazen Ghannam <yazen=2Eghann=
am@amd=2Ecom> wrote:
>> >On Thu, Feb 27, 2025 at 04:25:00PM +0100, Borislav Petkov wrote:
>> >> On Thu, Feb 13, 2025 at 04:45:55PM +0000, Yazen Ghannam wrote:
>> >> > Also, move __mcheck_cpu_init_generic() after
>> >> > __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the=
 first
>> >> > MCA polling event=2E
>> >>=20
>> >> The reason being?
>> >>=20
>> >> Precaution?
>> >>=20
>> >> It was this way since forever, why are you moving it now? Any partic=
ular
>> >> reason?
>> >>=20
>> >
>> >1) To read/clear old errors before turning on MCA=2E The updated
>> >__mcheck_cpu_init_prepare_banks() function does this for the MCi_CTL
>> >registers=2E This patch does this for the MCG_CTL register too=2E
>> >
>> >2) To ensure that vendor-specific setup is finished beforehand also=2E
>>=20
>> That doesn't answer my question=2E All of the above gets done even with=
out shuffling the order=2E=2E=2E
>>=20
>>=20
>
>MCA banks can start logging errors once MCG_CTL is set=2E The AMD docs sa=
y
>"The operating system must initialize the MCA_CONFIG registers prior to
>initialization of the MCA_CTL registers=2E"
>
>"The MCA_CTL registers must be initialized prior to enabling the error
>reporting banks in MCG_CTL"=2E
>
>However, the Intel docs "Machine-Check Initialization Pseudocode" say
>MCG_CTL first then MCi_CTL=2E
>
>But both agree that CR4=2EMCE should be set last=2E
>
>We have an old thread on the topic that led to this patch=2E
>https://lore=2Ekernel=2Eorg/all/YqJHwXkg3Ny9fI3s@yaz-fattaah/
>
>And it seemed okay at the time=2E
>https://lore=2Ekernel=2Eorg/all/YrnTMmwl5TrHwT9J@zn=2Etnic/
>
>I don't think anything much has changed since then, so I included the
>old patch again in this set=2E
>
>Thanks,
>Yazen

This is exactly what needs to be in the commit message - why is the change=
 being done=2E=20
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

