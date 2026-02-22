Return-Path: <linux-edac+bounces-5731-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Lv3XIUtwmmmcbgMAu9opvQ
	(envelope-from <linux-edac+bounces-5731-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 03:56:11 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03816E6DD
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 03:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694FF301A71A
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 02:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7E3D561;
	Sun, 22 Feb 2026 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NTaMFjAb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DFA55;
	Sun, 22 Feb 2026 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771728967; cv=none; b=AIsuCZNsKnc5EUshCQVUrXzlq4Vou/vwf3QeE3cLERQn6N3glr0yPStrZtREhxI693ZqFQqSZfJQWm6vP7hzdiMgNMuNoCeiqEbNLH2Kc/hejBs2HFZbbXZke660Ai3EmLoYU3DTlxO11pIpBEaDoTkPEs5cSiWzttvTweclK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771728967; c=relaxed/simple;
	bh=WVAI0xd1d99Z/NtbidmoMIbBfNb8vsRdTZicJfCBlLI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rqZLXYfyHXbvPdVBDeG2nevRelh7neHVhBg6c1SHDcKSr+Lqeyp8PMwFMuHuJr89ZabBsn383Tpy1LmHG1tUf26sgu4i9ckjQ5GR2qI9AWCcBeMjdeUigWFHvoFPxOqphtb+58srvQcEG/IVVZHLklvTV5cLmMh3bFPhZ3P/th4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NTaMFjAb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3BBBD40E035C;
	Sun, 22 Feb 2026 02:45:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jSV2MtLwLlCW; Sun, 22 Feb 2026 02:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1771728354; bh=WVAI0xd1d99Z/NtbidmoMIbBfNb8vsRdTZicJfCBlLI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NTaMFjAbtDGqeeoWtQPku0HrywgN4wLDHos7djf43fS1/fb8u/kmZVKY984Bsp49S
	 sBcjRTr0aH/9Waf2rmSFNpoagu/n9SIH9cEtsEPYu5A0EBOsDISjZeH5wWGrZBsAaY
	 nU9TKkCsgE3/UF4qQDZ2oMQyw6q20g/z4iW/jTksZ3apvP0PCCQHyXO+39Ttg/QRMY
	 AMZ8C4cfEGPrayQDOO0tMULHRo7NCkl1QFABxDczDMEUtLb1Kf1wTql02xwzSL+OmY
	 hbK/GwfQpJ0N8uIEgpeEB8TjyeCdB76ooB/pmYPhTsL3+6grgCULp2RvjGtbt+2Bwb
	 ZPodl98L3/mrClyFyA7rtQZTLq2NfuENSz9PJ5iBQ+ENjZkrHyG9dx/4MDUKmJZwhD
	 xoan9QzKIDMLi0C+hYt9y0ZJnW9UOq0UjwC2/sOHuRA2IMhrlkp9Ebe4rEsTVMVr6s
	 zbWtnTGNsvBSSrrgfp2Rgr01+uNpJFxSS/93agTCJfXcX9Wxi1cusF0U3tZrKEIU7U
	 eDXeh+6irFzY9blmHZ0wz7QpqAxpM3Zz7L2HNe/Zyq8WfewpWUR4d1k/LkBdwM85BI
	 rJPgyBnvE3Y7knFAJTfj4SO8FywzE+EP0mOWkAQfpaNLusV5wUPD/xOyPu1q7M+32A
	 Ga7p6md2S5ryPX7yBrWGqEU4=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3030:2b:5189:5124:803b:30b8:e5c5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E4A940E0219;
	Sun, 22 Feb 2026 02:45:48 +0000 (UTC)
Date: Sun, 22 Feb 2026 02:44:58 +0000
From: Borislav Petkov <bp@alien8.de>
To: Eric-Terminal <ericterminal@gmail.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
CC: Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_EDAC/versalnet=3A_Fix_resource_?=
 =?US-ASCII?Q?leaks_and_NULL_derefs_in_init=5Fversalnet=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260221071643.23702-1-ericterminal@gmail.com>
References: <20260221071643.23702-1-ericterminal@gmail.com>
Message-ID: <997BD3CE-CB86-4A7A-A3AA-E5B15B6FA39C@alien8.de>
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
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5731-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9C03816E6DD
X-Rspamd-Action: no action

On February 21, 2026 7:16:43 AM UTC, Eric-Terminal <ericterminal@gmail=2Eco=
m> wrote:
>init_versalnet() has several bugs in its error handling:

I'm waiting for a while now for Shubhrajyoti to do something about some ou=
tstanding issues there but no move=2E Might as well remove him from MAINTAI=
NERS and let this driver rot=2E=2E=2E

>Signed-off-by: Eric-Terminal <ericterminal@gmail=2Ecom>

Your last name is "Terminal"?!?

--=20
Small device=2E Typos and formatting crap

