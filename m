Return-Path: <linux-edac+bounces-5656-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O3mMnVpcGkVXwAAu9opvQ
	(envelope-from <linux-edac+bounces-5656-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 21 Jan 2026 06:51:49 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 748DC51B8C
	for <lists+linux-edac@lfdr.de>; Wed, 21 Jan 2026 06:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 674CB6C3A2A
	for <lists+linux-edac@lfdr.de>; Wed, 21 Jan 2026 05:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC67425CEB;
	Wed, 21 Jan 2026 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fzktm2V0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D1318ED4
	for <linux-edac@vger.kernel.org>; Wed, 21 Jan 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974684; cv=pass; b=HBsky8pZmTnarkQty88xUXt+P8cfMlcAtWyAbbxWF1CXOW9H06M95bKhHLxnMHmHFiodNhcPyZUXdHXQbTX1loJZ+hARK66TFX7XeZmwohugERgKesZh9BriNVNCmoyP+vjJP1s/Ep+GXv6YeiDvFJTeLzO777mkdLdgEni2bU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974684; c=relaxed/simple;
	bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxsUwzqk8aIqdz0QlrJGQ/JjyyaWVk10AI02GVEUoPUIuLXeque2DWBH0FkL9raC2ZWfkmZwZWcp9uF6lNiDZy1Ojp28y4Agldln0wc1Ad8MNW6df5ILGDQBYI1NMMCc4x2oQQeobn1/eF/3QHdOLZ/oUJBeeADQFyzuHVhsU8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fzktm2V0; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee730612dso46945e9.0
        for <linux-edac@vger.kernel.org>; Tue, 20 Jan 2026 21:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768974679; cv=none;
        d=google.com; s=arc-20240605;
        b=jXIxI64eR6T6sAVMTADeY5vg8Mz5ZukaNmrMWsD9v90Eicli5mKn5bUMMxbLpv3jDr
         Zf4wX6UZZjyXLLmLPpaiGbQarDmGUSUSTxetkPX36kgvcIGAg+Uup8fhjbuMKCufKyEx
         Rz5Mx2anm1pichl0gTE7Ik1ZqiuBiq+t0ty202cN0z0QpVKvTUYK09UqQd1tx30t/Bsk
         Q5D1KXZvLsiMhuqe6H2SMp+ZMlxpSrtdVRa5nRrjJm614Mg294CQC3fdKX9ccmhWqX5w
         Xsp0fnNae/tJDSfpHpFX4LZPYOCyoWaPTEfDC4rdo9FuN7TvVDS6PLHAqafFViH44Lvl
         NjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
        fh=kKQhl8u5+PMfl0Gk71oP/rVOw8ZMMX9mPy06sfx/GSs=;
        b=Cp+JSE2eYDw8f1vS9U2pYo/prege7SsJ5FlCBfGihA+MydLfKjrjhsPxir8naD1862
         I5lt5jGlfuty3MSmiiSKRhvyB7WJPCAyaqg/O0n4XCS6HCZxNU4flovrhubVqx378fkw
         1Y9hPz7ppXi0LkcSl5X/W5mD2F+VvNYxtZZJKTMwcZLfcX3QABEaymb+kLeoUc7UsyRK
         xHyBhOkZek9b3sxBsbMaSCMoxAoIQr24Lj7OiGu+WOLMrRvlvReNLMUphLEd2wzvkbjh
         gFAPpP7RH48BSzdl2bY4n/ocmYw8MBLD4qe6X8e1SgnzrMDLtKwBYWhk/SSnUsoj6GE+
         F9zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768974679; x=1769579479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
        b=Fzktm2V0/f3RiRVqNd8r5aVN3qgiJexDV49Id2wNmpLp66AiGvkPwmFOdwlacpPuAw
         KRLpeiDZ3jO6ZbMLPKb0lNxx0ikiJyVXfYir1tLFuzEAFawbQQfrEdX7HV3Q6YDpx2We
         pGDWUXKLO+Z7B/9012FKnJm4APSW3hC4NcIiXsrw9z1WgUkkeW3/7E2R6t5n6CDpNlXb
         g/QUMZJ2TnAkCGs2J2AFsyA3gNf/yIPyNLYRLgMVDlMmisfgMGXdluHiaj5Z7KaBGL7N
         F0e+0WsktYsyByQ/Rrhm1oDwtuqvxSmZGB53Viur662jKHe2iFwnDRGA5XOI3933C+oJ
         3djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974679; x=1769579479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
        b=DRQwVMqNAx5eO0o0N/EAM9784UkvWmbOLUfj9juzqAfRYmurcLh/eejoFnZse2ldxT
         4qMTpdoKt60tQlnbdZGLEM4/rqbaE6oncPTdVE95lBkrE9gM/7sZnA6v1QQdAzrOz65C
         AO7bEViXBQzRsDSbIetNPzWmwlLVWaR7abFDDFVZvnaCiT5kTlIK3OZQ3pOgs+LDEofK
         O8/3LKdmaf3VGstCorxFouKoR2h1Z7szzOR6RORKIqhDpec156Yjep12084YsDTrWRfh
         EmoYpTMcsYGzgzHyvQg4z8dGj+PnsEGHEbTR64ZeiWTK8HKstZ6j1DJSIAiL1654yd2u
         VEgg==
X-Forwarded-Encrypted: i=1; AJvYcCVAtrlxZDo09bhH1/koK5wIe7cLDi274Q/Esj6JlzHAHQob0tXimfQntApkjUIsJmo8qeNh9n2a4zlT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nanhWIKaQC4hrbeyZgGZz18KkK2q+WTRTq7fUyCXXen1zfpo
	uRj1MqRhjLCxNBcO3IC8vutL5cTw+layW5NHXty1TCIeQj6k53TytCAw085FSCK8dy2+yq2SSn0
	BzGIh/ytQ1iqfCJn3oaYh6SaGoFBFOVrumfo8TYd0
X-Gm-Gg: AZuq6aJtEjTHktZpTnIOJPYEMJKwDCccxhNi4HlF12mEqLeoo71dhDCkK2hWM3jvCt0
	ICwxNvmXQSbuJPnkv7/6CsGSiO5hbPzep+MUE6hJ8iS49eb7U8xIuZFHi5+ioaBhGp7YUtkT45Q
	h8E/J3P7F1Pu4Q4wNil9e1XM5vEq1MUzBymxMpJzZB9hGdreJrcYUi8bygI2PUvnhMh/Zvo408+
	1/I0y9LFPw9hyfEeJnmxvRP/IPSbywkUJ+roywn4TZg8OMpSD2T7tTCy0sOcOP/UaI4x79pXhYC
	/jT/1oQFgK6Tey2KgdC9zcW/Pnic
X-Received: by 2002:a05:600c:3d97:b0:475:da0c:38a8 with SMTP id
 5b1f17b1804b1-480425622f1mr695955e9.4.1768974679127; Tue, 20 Jan 2026
 21:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102184434.2406-1-ankita@nvidia.com> <CACw3F51k=sFtXB1JE3HCcXP6EA0Tt4Yf44VUi3JLz0bgW-aArQ@mail.gmail.com>
 <SA1PR12MB71997E2E101E55CDE65EA6B3B08AA@SA1PR12MB7199.namprd12.prod.outlook.com>
 <CACw3F51qrBXnN370Btk7=bcKU7s44nmQYfN=EAfq25MondRUNA@mail.gmail.com>
In-Reply-To: <CACw3F51qrBXnN370Btk7=bcKU7s44nmQYfN=EAfq25MondRUNA@mail.gmail.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 20 Jan 2026 21:51:07 -0800
X-Gm-Features: AZwV_QgaTupq6DBMCeoCVM1hXfaRoAYoBx_XZxcQfdu6RhES7vwnX4BR3BC4bEE
Message-ID: <CACw3F53n1ieCfP7Dye96S1WPpein+x6wTVUhE4aVkRG=VppC-g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: Implement ECC handling for pfn with no struct page
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Aniket Agashe <aniketa@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"rafael@kernel.org" <rafael@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, 
	"mchehab@kernel.org" <mchehab@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "alex@shazbot.org" <alex@shazbot.org>, Neo Jia <cjia@nvidia.com>, 
	Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Dheeraj Nigam <dnigam@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>, 
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>, 
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5656-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[nvidia.com,huawei.com,gmail.com,linux-foundation.org,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,intel.com,alien8.de,shazbot.org,vger.kernel.org,kvack.org,amd.com,baylibre.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 748DC51B8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:28=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> On Fri, Jan 16, 2026 at 9:36=E2=80=AFPM Ankit Agrawal <ankita@nvidia.com>=
 wrote:
> >
> > >>
> > >> v2 -> v3
> > >> - Rebased to v6.17-rc7.
> > >> - Skipped the unmapping of PFNMAP during reception of poison. Sugges=
ted by
> > >> Jason Gunthorpe, Jiaqi Yan, Vikram Sethi (Thanks!)
> > >> - Updated the check to prevent multiple registration to the same PFN
> > >> range using interval_tree_iter_first. Thanks Shameer Kolothum for th=
e
> > >> suggestion.
> > >> - Removed the callback function in the nvgrace-gpu requiring trackin=
g of
> > >> poisoned PFN as it isn't required anymore.
> > >
> > > Hi Ankit,
> > >
> > >
> > > I get that for nvgrace-gpu driver, you removed pfn_address_space_ops
> > > because there is no need to unmap poisoned HBM page.
> > >
> > > What about the nvgrace-egm driver? Now that you removed the
> > > pfn_address_space_ops callback from pfn_address_space in [1], how can
> > > nvgrace-egm driver know the poisoned EGM pages at runtime?
> > >
> > > I expect the functionality to return retired pages should also includ=
e
> > > runtime poisoned pages, which are not in the list queried from
> > > egm-retired-pages-data-base during initialization. Or maybe my
> > > expection is wrong/obsolete?
> >
> > Hi Jiaqi, yes the EGM code will include consideration for runtime
> > poisoned pages as well. It will now instead make use of the
> > pfn_to_vma_pgoff callback merged through https://github.com/torvalds/li=
nux/commit/e6dbcb7c0e7b508d443a9aa6f77f63a2f83b1ae4
>
> Thank you! Sorry I wasn't following that thread closely and missed it.

Sorry, one more quesiton. I saw [3] implemented pfn_to_vma_pgoff
callback in nvgrace gpu driver. Is EGM driver's callback posted
somewhere?

[3] https://lore.kernel.org/all/20251211070603.338701-2-ankita@nvidia.com/T=
/#mcc9ccec90b1ca755ad9af0a821f5ce524fed0ffc


>
> >
> > > [1] https://lore.kernel.org/linux-mm/20230920140210.12663-2-ankita@nv=
idia.com
> > > [2] https://lore.kernel.org/kvm/20250904040828.319452-12-ankita@nvidi=
a.com
> >

