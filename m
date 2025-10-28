Return-Path: <linux-edac+bounces-5241-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB07C1651A
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 18:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9356A403669
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BBE34575E;
	Tue, 28 Oct 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GZVLBtOc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1589225402;
	Tue, 28 Oct 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673643; cv=none; b=ts0TzW3aAQtC2DanPG/N4XIDDuoIqpjdcICxgh43lvgk8BsLJssrFSKm+VgfTNLqENCWNpObqszNZpNnclOLYbMpN6Fm8dpQjbDs5O4DiJFcX03JgXuOO80oYOgE8SviO1JAmXHdkB8yzGB59auYABFNlsjo4qR7gwPIcHRR0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673643; c=relaxed/simple;
	bh=P295r9+6SdHA5A6u2aoFNKPmIUEH3ZUuo7xEs0+qf/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTJJgCPKlwdjBd8Deb8tqWnyj6HB/E/gqyI/kOCcSChSbj0yYitWDP3xF7N/2hRqdpLWZGtR1wzuEgneumWTtZN3W6yTT6oLH8C4W2BOBKrYAJsACxFU7aJ1K+u64owqcIgCrPBn61P6lGe46hdwo9QKu2h9s9Qd8jn/sHa9e7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GZVLBtOc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D59DD40E01A5;
	Tue, 28 Oct 2025 17:47:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id arMPkg8uknQV; Tue, 28 Oct 2025 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761673634; bh=ybo6xcppig+jStlIPQv996AyXfzWzyye/OuJkMRjEwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZVLBtOcRtJYxby18y7C06R/6G6ZKsiPLyWRRUOmh7ADCriMDWUXkhwp7gLOE1M3p
	 oJ+uMEEB1qDUeA1Oj8NKje9EibRm8ejsz9rs8Amxz5qxw1E5Xyi63MbN0JCjM/p1Km
	 TdJDjsQPcRer+/WD4l7dV9JJfsrAF8ar9L+lINBuknEZ3pDwn6/+1ZEkMmzss+81II
	 e9ykSx0NG/DRLXQ7NvFeOqPHrK7Qopf/5uVwQkUyr3nAEXPcn2PhfyTKMl7f8TN/gE
	 uQgGqkIu08193lX4IDRoCkcUVkZdafn1oC87MMiNu/c1sDDHeYrUbWmuByux58RD2V
	 ChFAdRv966OayudaAiDPV4gk1A3rO7+pq8oEoyEghj781eSv6LJ28MsJTbb2j2Eo/Q
	 hzvfGdCio79IL6quY2LzUam6gf3zVo2tZm+AYQW14gaJuxoOaK8R/DutHzEVwNr4j9
	 IZHtJQi6AdcXN2IIomI/epEdzRG0F9LArlKV/RsDc5o28PEqfbNw4N0iooeSsHy0aS
	 QS/oPO99MqcJOq2PKdN5uk5SlmFKg6JetOja8K3Ky3x4L0bcWjVBQR5PY1PTwu83oy
	 gItmj9u+l537b9OdWYrlC5CJt/Iw0+enatNig0pDDN7E4jFLPTrmfLKzdOHdAlT28y
	 SBp5WctlhA5EfNVUXC4JRunE=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D501640E00DA;
	Tue, 28 Oct 2025 17:47:01 +0000 (UTC)
Date: Tue, 28 Oct 2025 18:46:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251028174656.GBaQEBkOErfNAJbJsf@fat_crate.local>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
 <20251027141139.GA51741@yaz-khff2.amd.com>
 <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
 <20251028154258.GA526743@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028154258.GA526743@yaz-khff2.amd.com>

On Tue, Oct 28, 2025 at 11:42:58AM -0400, Yazen Ghannam wrote:
> Yes, fair point. How about this?
> 
> 	/*
> 	 * If MCA_STATUS has a valid error of any type, then use it.
> 	 *
> 	 * If the error happens to be a deferred error, then the copy
> 	 * saved in MCA_DESTAT will be cleared at the end of the
> 	 * handler.
> 	 *
> 	 * If MCA_STATUS does not have a valid error, then check
> 	 * MCA_DESTAT for a valid deferred error.
> 	 */

Well, we already have this at the top:

/* 
 * We have three scenarios for checking for Deferred errors:
 * 
 * 1) Non-SMCA systems check MCA_STATUS and log error if found.
 * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
 *    clear MCA_DESTAT.
 * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
 *    log it.
 */

 and that is good enough IMO. The rest people can read out from the code.

> Okay, agreed. I think this entire second comment can be removed.

Gone.

IOW, this:

/* 
 * We have three scenarios for checking for Deferred errors:
 * 
 * 1) Non-SMCA systems check MCA_STATUS and log error if found.
 * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
 *    clear MCA_DESTAT.
 * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
 *    log it.
 */
static bool smca_should_log_poll_error(struct mce *m)
{
        if (m->status & MCI_STATUS_VAL)
                return true;
 
        m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
        if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
                m->kflags |= MCE_CHECK_DFR_REGS;
                return true;
        }
 
        return false;
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

