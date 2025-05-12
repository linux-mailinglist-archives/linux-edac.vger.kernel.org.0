Return-Path: <linux-edac+bounces-3882-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B50AB31D8
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEFD16E472
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C312580F4;
	Mon, 12 May 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jkfD8kI9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A4D528;
	Mon, 12 May 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039153; cv=none; b=JhFd34a04iji401WwLWhiO3ki2nilLm4l9iz59nRjdxDoEd40L2YuIWTl36zl45D0Lkyq872Jqo6NWEIHl1jFd3N9maHc6cSw5XiTnJmiPu9f5SMn/BJcKyr4w81P3Jlga5s7tP5LEZf8iSDrohH3qp02kK/hHvdgDdU5FUVf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039153; c=relaxed/simple;
	bh=v7Q321BVuunXSgyj7aSO4QoqmSPSdep7tFWOWDiZU+A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jdF9zYXOyKx0n/+vNugp/CeBhHg9cAqeowy/BKzAwaA/oOv5xovr3psdY6SzL6iJASvZd3K4IxhjLoyc93/wDf5YqpZm323EH1/BmNfHKjgySC5LT5IjwdicNHQ76dBM9BQD/X1AiPK2oPweV2LdO5KY82ER2U6+ogM4iZMjaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jkfD8kI9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0304840E01ED;
	Mon, 12 May 2025 08:39:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2n3dMIktGZCl; Mon, 12 May 2025 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747039141; bh=KB4Is1RNA340QS9c49/4swl8GNEr6mQ3bP8uGT6F+kA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jkfD8kI9m7w/EL5BJE8jNCY6yLd40dk3ED7YccKH3Y+cM+awVeLZgBSNcTZiwb2Hs
	 ojhWgZaaHh0CqcJ6X4SQvPZG23k1o/XfeHRVFByAHAL2yraMOewMqhW85BshtzOdAd
	 tNghZNy4Cz5gH4aTE726SN4k0OaXBpBwNoJTLh/5A1RQwMGRR42QnHrbpdbxPd++2J
	 79v/w1xseqCjsoLvhnxlqd2s/2mZlC75PyDkkySfjRjt8TBgKldIFkD+bEudxVhhWA
	 QICW6TB3q8pqwgLfNXprip8t1nmASQOpY4wqNw3BVNgNycK5Yfdt+zBoDYHbNs+fbf
	 H8+I5qb42JHodExDXa63OExDLwby6JUp1eQmYKMmkREwHHmNL4ovQA2CbEOe7zsdb2
	 izJNBL6IbDUpMdniZkq8g3Mm92GlDYJwWDOhuDakx6bIfazKYCJaycmQjZkMw6ef9h
	 0Vyjtbm4+i6Qu8sGNf1ffcvdaxE6mSNK6gG3q+5ZUvj6oj2LLnWtl0Qa+MwaLk1tHf
	 eodGn+JEyiEcsb99P7ABXIXFuGgFkBxA3vb2DwyDVLjS/ZCV+MVna/TfniMfvBO4eR
	 v/j/dUDdatqtvArGB4wtp556TC5QGZUD0l7gUq6xnbWtSsDGKL2xKzRx7OLIzAmvv9
	 AbZozIBFiN9Fby/J9iehu9/k=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:204:a05a:7dcf:8efb:5016:7f05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 221DE40E023B;
	Mon, 12 May 2025 08:38:27 +0000 (UTC)
Date: Mon, 12 May 2025 10:38:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, shiju.jose@huawei.com
CC: linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, rafael@kernel.org, tony.luck@intel.com,
 lenb@kernel.org, leo.duran@amd.com, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, linux-mm@kvack.org, linuxarm@huawei.com,
 rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
 dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
Subject: Re: [PATCH v5 0/2] ACPI: Add support for ACPI RAS2 feature table
User-Agent: K-9 Mail for Android
In-Reply-To: <20250512091644.00001598@huawei.com>
References: <20250507214344.709-1-shiju.jose@huawei.com> <20250512091644.00001598@huawei.com>
Message-ID: <3A6C3FC9-B347-4FA9-BA88-3DAF423853C5@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 12, 2025 10:16:44 AM GMT+02:00, Jonathan Cameron <Jonathan=2ECameron=
@huawei=2Ecom> wrote:
>What path do we expect this little series to take forwards?
>
>I'm kind of assuming through ACPI given the acpica dependency,=20

Yeah, probably better thru the ACPI tree=2E=2E=2E

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

