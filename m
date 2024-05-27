Return-Path: <linux-edac+bounces-1137-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8128CFC81
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A832B206A8
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80F713048C;
	Mon, 27 May 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YyTu/wxD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1246CDB1;
	Mon, 27 May 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801059; cv=none; b=Wze2Rp6CNf5U5kfNa0TSW83jP9KCzBv1/JN+D0u7vUOgCfVRbOIC/kWCzpb6uLiahBtRiYjezYUCiOsKLkQ5HAw9lfi4Riobje348V6rLtiNXDJZWZml52L5Fhe1rj7Rg4bQ/g3TKvc+eX6ye0lJDOuF+gmHDV53f28NiNuaTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801059; c=relaxed/simple;
	bh=hna6wiJn5J3YlKLz1DIYbTqakeYLBOtj6qBnzA4Yaic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+hL1w7SbO5L2j1+ukNfPf8DlpWXXG59h96sguVzeClEI9AtiIT3+5reVVaam1YOxRIZUoO6aWHXqXJ6cw2/hgQPeY+is5F8BbLK6F8VYx4QjvgFRKPwQrPv94HPf/DGwtd1vlLq9CjspSyOUFu4cDJhs3fUDjYECgWXULDf+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YyTu/wxD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F9A940E01E8;
	Mon, 27 May 2024 09:10:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KohNzWZ-0NVO; Mon, 27 May 2024 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716801045; bh=9w6qbzhl3mSC9BIHJao+s6F+3dipO5EQO7O9UXzK/zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyTu/wxDSCSpg3L0kZMPZppqT/G+B//WNjrOLn+PjqrbbMgu9dR0NVDH28KuTRxVm
	 C7MPk9kDlKbxXo6Ozp9t9p5hAuS8WRuOaZA1NuVCjdqnqmhKiV0yYcDCJ0exzbHRRO
	 NugkfCcU9KYfpFbohF7s7CMfvrAqH+XMC2Qa4YQOnPe563GpTIkLFD6Iz+fgd7aUTG
	 2x6WelBxPxHgSP919X3hCV5laUPRAippv0q/HRbtzWnsOkpbVWXnzL8hr2P2FhYWeD
	 KvHyKFskhgtz2kXi6tKVL+/y6p0nnCdEkMQBnBUsXZhGQiEfJPTRx3LHyxKtadwvjU
	 c1qdGPpc6DnFOXMssojWCwGrOUZcuHDI53O8UQgthz9LELy2OdCglqDqSs1ACih7kI
	 7JMSRUOvGesXZmn/q+fnw3PrQBEsX2yfhW01zPT1nv+gM7PwIyNu20y/akRoRYfs4X
	 uGXp1gbnlDlmjVgzgf5KmIB7G543KcpaNBCxy8SbrUsPcqpIEAwrTUyoHZ2mV2RwEz
	 ezqAhf9DxvnEQ1HrjhsLxFJOdDQe+wYz8KqRlQILtCwm5S/rQiud3KZyr1AIQpyNWj
	 4NTDdQnFD94AOADNehNN7feDr+OnRr6lqEWqW8DTwRTvhPgvxo1M1S1+xfAqfdt/RK
	 6CLE1az6qWrGmVfm9qW8JuDs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9615A40E016A;
	Mon, 27 May 2024 09:09:58 +0000 (UTC)
Date: Mon, 27 May 2024 11:09:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240527090951.GAZlRN3wh9107DSfGK@fat_crate.local>
References: <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
 <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
 <663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
 <20240517121554.000031d4@Huawei.com>
 <20240517124418.00000b48@Huawei.com>
 <20240521080621.GBZkxV_ZWnbbrq-yV_@fat_crate.local>
 <20240522104017.00003904@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522104017.00003904@Huawei.com>

On Wed, May 22, 2024 at 10:40:17AM +0100, Jonathan Cameron wrote:
> Where I've used the symlink approach in the past, it has always
> been about keeping a legacy interface in place, not where I'd start
> with something new.   Hence I think this is a question of how far
> we 'breakaway' from existing edac structure.

Yes, since we're designing this anew, we can do whatever we prefer. So
let's do the standard driver model stuff.

However, there's also /sys/devices/system/edac/ so I don't know what the
right thing to do there is. Are we supposed to put everything under
/sys/bus/edac now and /sys/devices/system/edac is wrong now and should
go away? Maybe we should talk to Greg first ... :)

> This suggests the second option above, but I wanted to confirm as Shiju
> and I read this differently.

As said, we wanna do the new correct way of how a sysfs interface should
look and leave the old one as it is.

> Ok. There is an existing is the minimal sysfs existing interface but I'm
> fine with ignoring it for now.

Yes, we don't know who's even using it and why. That's why I'm very
interested in how this new thing is going to be used so that we know
what we're committing to supporting forever.

> *much sympathy!*  As we ramp up more on this stuff, we'll try and
> help out where we can.

Always appreciated! :-)

> Hopefully we all agree on a unified solution being the target.
> 
> Feels like we are converging. Now we are down to the details :)

Yap.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

