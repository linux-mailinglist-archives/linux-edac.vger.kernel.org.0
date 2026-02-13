Return-Path: <linux-edac+bounces-5714-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MKcHggdj2lQJAEAu9opvQ
	(envelope-from <linux-edac+bounces-5714-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 13:46:00 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A976013620D
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 13:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B94E301152F
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0949347BD9;
	Fri, 13 Feb 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="r3oZXChP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67179191F92;
	Fri, 13 Feb 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986753; cv=none; b=hZKmgAYGSQ2Sz/LiAMWqBPJqU4pQWKKXcfDAIx1vznSEcIJMNpmzgnlC31FQ64G5oFFd/DOSHOkcuu+CKcex+TOY7rrbiwtn9rs4EwUFitLZLfxFios3NA8KpDQ2vmgk+ix2XKIsGNQB7iQDWADKUe/pSvbhiRcf9ZXaer5b/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986753; c=relaxed/simple;
	bh=wpdiCiCzi3kBnjKQy4QyFoP2Kd+De0vk87lx6HMOhZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4ymnPSl7Y+VIYNCDJInxIQcNRy9KMBmy1AvwXawdBtCpENtr2I67yCIzzGlEr7DVrr6XEQWHe2syYa/RvZNGBLfsRf4WckW+Wbp24T1k8/RO/ZZhVPlkLLUjif9LIMRLIgzz5Js0l4fwIMzK0KumRILdHXu4EsAFOfXgXqnnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=r3oZXChP; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770986725; x=1771591525; i=spasswolf@web.de;
	bh=PifJ3Vxvt+aCuhXceSXWRu3jIZxeq/nL+w3EeX5TPUI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r3oZXChPxWjA72lfdlKw4l65ykt5YsYu6XvrYhuY5llgArl8Qj+8f4wwx3A5+FTX
	 S/F3Zuh231zQH2+M43NjbA3vv9vbfKY1ZKCWPYLUABx9XZB03eLfBofsxxupf3jil
	 KuzA5+F+Cyf2ef3hZkUBpllD3SwI9EUjAeEZNRrNc13PLOouiupr+gxaIydgYRBOi
	 CIBPb7YZ8siVs14m/27SvJYp+keQFS5X+63hOorLJ+/OSJ7NXRvPfOrPqcrIVouth
	 cSVu3wh+Lx59LeTX385Wx02CSUS8t21OVGou62Xsxyvj0ZFZjOFYv7rNstQs301aq
	 4Ik+xxf/3ALRz5ejwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmho4-1vP02U3wv8-00c9dG; Fri, 13
 Feb 2026 13:45:25 +0100
Message-ID: <cb484717e2600ae729b55ccfc92e807d88e5ab31.camel@web.de>
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, spasswolf@web.de, Borislav
 Petkov	 <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, 	linux-next@vger.kernel.org,
 linux-edac@vger.kernel.org, 	linux-acpi@vger.kernel.org, x86@kernel.org,
 rafael@kernel.org, 	qiuxu.zhuo@intel.com,
 Smita.KoralahalliChannabasappa@amd.com
Date: Fri, 13 Feb 2026 13:45:23 +0100
In-Reply-To: <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
References: <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
		 <20250916140744.GA1054485@yaz-khff2.amd.com>
		 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
		 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
		 <20250917144148.GA1313380@yaz-khff2.amd.com>
		 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
		 <20250917192652.GA1610597@yaz-khff2.amd.com>
		 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
		 <20250918210005.GA2150610@yaz-khff2.amd.com>
		 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
		 <20251009132055.GA472268@yaz-khff2.amd.com>
	 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dpLOEXyeHgPxhgWra4gEHQSW3pIfMosO/VaB2p4QyCx3gHOJ/sS
 QXyMiSz76uxfdT3eZDregFXIs5iKdp5Un7FrAKBwPshvOkxNDdxy5NtkEoDIqpKYU7UWTFx
 pUhB8m86gJcKGlm0B7JOJFe3ilSN4nAPnS7C4OkaJ0/Wdoneb2DIaSLhU7Rkd/4rRk6URXx
 6qoEhIWgU2aaLo/QP0wZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wzvKiLqk74Y=;WL2VICgQkiuHK079Visx/bwqJ+v
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5714-lists,linux-edac=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[suse.com,web.de,alien8.de,intel.com,vger.kernel.org,kernel.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A976013620D
X-Rspamd-Action: no action

It happened again, this time on next-20260212 after about 3.5h:

Error message:
2026-02-13T12:47:34.505714+01:00 [T449218] mce: [Hardware Error]: Machine check events logged
2026-02-13T12:47:34.505729+01:00 [T449218] [Hardware Error]: Deferred error, no action required.
2026-02-13T12:47:34.505731+01:00 [T449218] [Hardware Error]: CPU:0 (19:50:0) MC11_STATUS[-|-|-|AddrV|-|-|-|Deferred|-|-]: 0x840090c800c98185
2026-02-13T12:47:34.505733+01:00 [T449218] [Hardware Error]: Error Addr: 0x003bd7a800000020
2026-02-13T12:47:34.505734+01:00 [T449218] [Hardware Error]: IPID: 0x000700b040000000
2026-02-13T12:47:34.505736+01:00 [T449218] [Hardware Error]: L3 Cache Ext. Error Code: 9
2026-02-13T12:47:34.505747+01:00 [T449218] [Hardware Error]: cache level: L1, tx: DATA

Output of
$ cat /proc/interrupts | grep -E "THR|MCP|MCE|DFR"
 THR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
0          0   Threshold APIC interrupts
 DFR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
0          0   Deferred Error APIC interrupts
 MCE:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
0          0   Machine check exceptions
 MCP:         48         48         48         48         48         48         48         48         48         48         48         48         48         48
48         48   Machine check polls

Output of (the non-zero error_count values {72,3165, 72,9} are
the same asin my mail 15.9.2025 so these do not change)
# find /sys/devices/system/machinecheck/ -name error_count -print -exec cat {} \;

/sys/devices/system/machinecheck/machinecheck15/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck15/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck15/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck15/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck15/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck15/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck2/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck2/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck2/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck2/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck2/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck2/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck13/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck13/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck13/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck13/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck13/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck13/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_0/l3_cache_0/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_7/l3_cache_7/error_count
72
/sys/devices/system/machinecheck/machinecheck0/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck0/umc_1/dram_ecc/error_count
0
/sys/devices/system/machinecheck/machinecheck0/umc_1/misc_umc/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_5/l3_cache_5/error_count
0
/sys/devices/system/machinecheck/machinecheck0/pie/pie/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_3/l3_cache_3/error_count
0
/sys/devices/system/machinecheck/machinecheck0/coherent_slave_0/coherent_slave_0/error_count
0
/sys/devices/system/machinecheck/machinecheck0/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_1/l3_cache_1/error_count
0
/sys/devices/system/machinecheck/machinecheck0/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_6/l3_cache_6/error_count
3165
/sys/devices/system/machinecheck/machinecheck0/umc_0/dram_ecc/error_count
0
/sys/devices/system/machinecheck/machinecheck0/umc_0/misc_umc/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_4/l3_cache_4/error_count
72
/sys/devices/system/machinecheck/machinecheck0/coherent_slave_1/coherent_slave_1/error_count
0
/sys/devices/system/machinecheck/machinecheck0/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck0/l3_cache_2/l3_cache_2/error_count
9
/sys/devices/system/machinecheck/machinecheck0/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck11/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck11/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck11/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck11/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck11/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck11/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck9/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck9/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck9/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck9/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck9/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck9/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck7/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck7/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck7/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck7/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck7/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck7/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck5/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck5/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck5/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck5/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck5/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck5/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck3/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck3/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck3/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck3/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck3/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck3/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck14/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck14/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck14/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck14/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck14/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck14/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck1/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck1/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck1/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck1/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck1/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck1/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck12/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck12/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck12/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck12/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck12/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck12/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck10/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck10/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck10/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck10/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck10/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck10/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck8/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck8/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck8/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck8/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck8/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck8/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck6/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck6/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck6/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck6/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck6/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck6/decode_unit/decode_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck4/execution_unit/execution_unit/error_count
0
/sys/devices/system/machinecheck/machinecheck4/insn_fetch/insn_fetch/error_count
0
/sys/devices/system/machinecheck/machinecheck4/floating_point/floating_point/error_count
0
/sys/devices/system/machinecheck/machinecheck4/load_store/load_store/error_count
0
/sys/devices/system/machinecheck/machinecheck4/l2_cache/l2_cache/error_count
0
/sys/devices/system/machinecheck/machinecheck4/decode_unit/decode_unit/error_count
0

I also did run memtest86+, 5 complete runs (~4.5h) passed without fail.

Bert Karwatzki

