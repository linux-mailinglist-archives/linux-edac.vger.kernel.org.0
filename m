Return-Path: <linux-edac+bounces-5702-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I4BEtYfimnLHQAAu9opvQ
	(envelope-from <linux-edac+bounces-5702-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:56:38 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86235113483
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C73E302D526
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791F30BBB6;
	Mon,  9 Feb 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Bm7Xdvik"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192925F984;
	Mon,  9 Feb 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659649; cv=none; b=nMI+iJIDq9D3ukPpIMWrRStB+OV0m4OvBXM9/yq8/zaF8jTF34nD/gy5v459G3ygfeiICnay1t47/oGD6YIMvQosAoaGos/KqbkMVRr0ivjQyRbkrk+F+YFNbL0FaH+wOGi6KIfdu+oLlAUqjFdkI/EnyDkpHKnwJ1IUJVUtpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659649; c=relaxed/simple;
	bh=IFE9mUPVVnabfECza5LBS965ldURvgAIVILjbBN+2Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfABwYUimZ63SXFdrt3oARaBDWZck35QfiAz3rd1TxLqLC7N/smVi24adJ+zMlxM4HMnh0N3tob0xfla5NEu9f4EUQp5AA6xAVlBbr5yshcZ//43hsOHXwXavEKv0s1HTlx2KO2uCrB2p4h6gO6Ceyfa/aorCkl7jUAAgRS0jmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Bm7Xdvik; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E1B440E0364;
	Mon,  9 Feb 2026 17:54:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EyfyrXE62IML; Mon,  9 Feb 2026 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770659643; bh=8ZjBfYx1JUaR52caXfkAQ7PrcK9d5bEMCEaQL75MPVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bm7XdvikBate+WZsLz5AQMTDqowuSuOre57lx1/ybcULKzJipM/iduH9durvMOsQc
	 A61Hj+0Aal+SwoJ4XAKzXj44yuRhG1kyBUkpbfWZUIi+cotTH+P17CScBb39zLwZl8
	 ijAQWplokD7a0828NuBx/5fN5gi80lpboN9uGxPdU8U6i164jnW9x9qVY4Y93YAW3u
	 5kGtcNIP+nsqTsN8IUBHfgC8cdfaYRIalHDNM4ikegxojCYKWAWmKEmjBIcLtz8V/H
	 MKqjyrNIxVXGMHKCNc95hABnrmuKYpbEFWJlJbwxO4YLYQ1Sq5iNJsovNVr3EjYlxh
	 jNnX8REiboujQLCqp/+ygII9jFwb7KNpa3YTwGJvL5+4bEoeBv6LJWrZZQQnbwJZLQ
	 bRoyExC+RnyUW/IBjD6WI12qnJ3gwFuc+hayLmInIi4MjKr6FI2T/xpi3Ujx4z4bYa
	 hGV7alewuzlppOpLQeNoJdEZY71shGRUdd4TZ1W57wZhYba35v6oNYPlqYwzTna9JV
	 Vz+QBBHXVne7U3Ct5nP5kIehSJ1vM06BY+kFftqdVeF5yACIaugmSC6qVJuE37FXMY
	 +ZkGAR5TXzbCe46FdoQfi3GjYKbBBXUbAucNNQE4enlIe3nxcCN0U/QyG0IT1rGA+U
	 bciK1Mj3s0ptbSlOhEuru/pM=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C3B5740E035F;
	Mon,  9 Feb 2026 17:53:50 +0000 (UTC)
Date: Mon, 9 Feb 2026 18:53:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: William Roche <william.roche@oracle.com>,
	"Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"Allen, John" <John.Allen@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
Message-ID: <20260209175349.GEaYofLVlR2MG7CFyS@fat_crate.local>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
 <20260209173619.GCaYobE1nME_z-1z2U@fat_crate.local>
 <SJ1PR11MB6083618404B9418F0BDB6AB6FC65A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083618404B9418F0BDB6AB6FC65A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5702-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:dkim,fat_crate.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86235113483
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 05:38:58PM +0000, Luck, Tony wrote:
> > This enablement is not meant for VM use. Why do we care about injecting hw
> > errors in a guest?
> 
> The guest may be able to just kill a process and keep running.

I have heard about injecting errors into qemu/kvm perhaps a decade ago and
nothing ever since. Either it has been working perfectly since then or no one
cares until now.

So the guest "may" be able to do a lot of things - question is, do we support
it and how do we test for it in the future so that it doesn't break.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

