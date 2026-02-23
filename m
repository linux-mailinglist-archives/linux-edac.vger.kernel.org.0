Return-Path: <linux-edac+bounces-5736-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOp9BdQunGkKAgQAu9opvQ
	(envelope-from <linux-edac+bounces-5736-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 11:41:24 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF2175072
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 11:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 469813004F3C
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20E34EF01;
	Mon, 23 Feb 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yf9y/PUS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DEC1A9F8C;
	Mon, 23 Feb 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843281; cv=none; b=V6h+MKUVT2DRrHX7lS9fDWAgxCT9vFH6TIZcgYl4ENzcV8H3WSd+J5142dnO5v656zqZZ+6e3pwhWQAb1tvkdJNX8CDxQUIz/KkULO+XK0q/6wEFfrAdtXdGB0c+ICzGj2Wf2dxn6MJCLcJ7LyOqeyCDdNJ8e+RoRFmTOKb7bF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843281; c=relaxed/simple;
	bh=8h0KUzKwwUJ7QP6LDtw6DLcIjnlemUu1Q22H06hv/z8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FuHWkqrghWoP94aYyglMqUZyyW2PZCCBzm1bY75VrGfTreSb1UZdBSSoEGm6LCCVsVgabjBctE2UOulpAguZAlz9AbPlfNBAvmRdNmUiN0DuPVtSOvChzHWrQdeiFGPXQImHy11Ux6/uBjwf2faioBIBgLzwTyxPVm0OUf+Q6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Yf9y/PUS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B24E840E0326;
	Mon, 23 Feb 2026 10:41:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iEIkMTcGHmIA; Mon, 23 Feb 2026 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1771843272; bh=8h0KUzKwwUJ7QP6LDtw6DLcIjnlemUu1Q22H06hv/z8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Yf9y/PUSpC91WeZfAlibNHz2lUnPaWOH4tpBuHVmlN7qcNLOGRhiQhV4fjbjV/x+I
	 WXWQJ/P+daFJh+XAr3zx8S0VIYfFsUY72sPGEp/EsVe5tCuPhBB84YvjZ/uWDpk+M9
	 NSj2EwvOwUZh9kt7egqeQDqL6iFcPBRyv4XuC5RbqI3lUrK4f2Y/91RYa5TgkcByv6
	 XQ+jY8yPcUPaOaIVQUMeIkdhyT95y4DYKb4m1ugV6ReG3UMafrPbt52deqkMvSGNC2
	 1ZGVrEMdFWGvmvQyJZBgSJcwGTeynDfDv+GHn7+kN/CYAkvifiwbo0oNZKMlcQHR2y
	 39wfilSnA/VVRfsgSAHM3GOORNnYfm/gDnRAOxeql79eXAxb46R9B4Utg670i/XPVP
	 XD/Tzn8WB1TtKG9OMXIzu+IOD+CQ+4vKnDNenLIfuiLi1cbxUSbnrri29EvJuIvHDx
	 qeRNI+zPddUjvkOPXRy4RPgQP/5FPdZVfdZBKaCJvpsvABwPZ94KTqIzVGNVsmvTUY
	 W4lb0KhGjFZgLL5+Kfkn1IpGm/vRiYMlpM9xdYEnaLQd+kjrUCEof5nQFDXvZwVQrr
	 Oqmu5E9dBWCact8RSuHPb2lxEki3VDkeuVJnVgnK5DagPO+iNtz+D+xCXyJit9bIw/
	 0SZOYxE+dRIHbxUrcTrDzzsA=
Received: from ehlo.thunderbird.net (unknown [IPv6:2409:8949:4344:8bf4:5c88:3e64:cb48:e6dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 039CE40E016D;
	Mon, 23 Feb 2026 10:41:05 +0000 (UTC)
Date: Mon, 23 Feb 2026 10:40:14 +0000
From: Borislav Petkov <bp@alien8.de>
To: Eric_Terminal <ericterminal@gmail.com>
CC: shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org, tony.luck@intel.com,
 linux-edac@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_EDAC/versalnet=3A_Fix_resource_?=
 =?US-ASCII?Q?leaks_and_NULL_derefs_in_init=5Fversalnet=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKNPVZAeEWB6Q0VRB7099s4xtLZXq9gqDnrfeYHkfFv9pEjaag@mail.gmail.com>
References: <CAKNPVZB1xhRnZ-DaEAWE3qn0EpdS9_q3w2xZKQmS0vhkXtaGvA@mail.gmail.com> <177183685191.2552489.7239740491321631280@Ubuntu-2204-jammy-amd64-base> <CAKNPVZAeEWB6Q0VRB7099s4xtLZXq9gqDnrfeYHkfFv9pEjaag@mail.gmail.com>
Message-ID: <A0F02AA6-0ADE-4C05-92A8-240C3F538066@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5736-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:mid,alien8.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84BF2175072
X-Rspamd-Action: no action

On February 23, 2026 10:08:02 AM UTC, Eric_Terminal <ericterminal@gmail=2Ec=
om> wrote:
>To explain the "way too polished English": English is not my native
>language=2E Because I want to show proper respect to the kernel
>community, I relied on translation and grammar tools to make sure my
>replies were polite and appropriate=2E That is why the text might look
>artificially perfect=2E

Such quality must come from a LLM-like tool=2E=2E=2E

>As for not complaining: I don't know how other submitters do it, but
>as a newcomer, I honestly didn't dare to complain on the mailing list=2E
>I simply assumed that complaining would leave a bad impression and
>might get my patch rejected=2E So I just tried my best to read the
>documentation and follow the rules as quickly as possible=2E

You should never aim for "quickly" but for correctly=2E Never rush your re=
plies=2E

>If I were a fully automated AI bot, I probably

So you are using some AI to generate your mails? You should state that in =
your commit message=2E

But I'll take a look at your patch first=2E=2E=2E

--=20
Small device=2E Typos and formatting crap

