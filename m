Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFFC2066A4
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jun 2020 23:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgFWVsZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Jun 2020 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbgFWVsZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Jun 2020 17:48:25 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE6C061573
        for <linux-edac@vger.kernel.org>; Tue, 23 Jun 2020 14:48:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so5550235edr.9
        for <linux-edac@vger.kernel.org>; Tue, 23 Jun 2020 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKFP4XmM+fzPiSTcosfxpar/wTtCL35clRf++Z9m9ME=;
        b=F1lsia2rHf1QjZHwmwFyb3rl/n1GTyxCp+pL4CQHVcYaIpRBQYuLp4VEvV3gTVzC6T
         Y0ZYtALWifMR47OpgIRXM+ZsNLyRakdttcIh1QXcyW2CAiGQCsWbnM2I+gyyYl6mOZI/
         JhkUDtfG2igjjw82AeihWkKCAY8uQjW8NlLFku1IHUco3VDRgf26H5wOdykBehKwbKD7
         zXhSocoxUkZekHACS2I7zQH1A44s44Foxo8kZI1Gfhg1+uuLgPmOLjIew4Ex/0pwVJpV
         iKTFVQcUjN50tdl3MkEkyPSFTjCpyPvys3RVxOb0l88vM9dYQ/ZIXUKrz2dOPmEtnOWg
         aZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKFP4XmM+fzPiSTcosfxpar/wTtCL35clRf++Z9m9ME=;
        b=q1AfsUwsmLSknZypZUXhrw9OM8aABR3zPp5zxkbyZiBUIln+wiKzuQZJsn0rHuHXCn
         En9KOQ64ZZLH6s7SNL6Qtdkps42I/iNPJeFjWW5+FLd3cvXNVYIjmwG1bw2gsD+J9yGV
         s+dPILC1TwVOZbjbzLb4pKWp1GgxpwxkWXPvYiNfstbpmV0irAPZzrMmd6TW+o6KyFMk
         WKpugsywIAe4v6YAucm0uKK7aUenqTnaOT2IbBsHr6bovR3AxMisnKBYLl0fJ2q6K6gb
         9j17mFjgsm12gkJIm/0qGVWVQMyZlzFvnb+Aj1z7JS25n3Z0c7UTEI5qyCJtN9uz5jcW
         AOFQ==
X-Gm-Message-State: AOAM530zA56Cq5xB1xGqUwZHQaJipxSwuNeXUVT25628RjehQvNhW0/x
        5Wv5I+0MbwT2K2UAkm6W+wOuHJpd+/9bOCVcmHrjeg==
X-Google-Smtp-Source: ABdhPJzeX9nxsXA3Zu7wxZMKFugqzwy3MnzLxu2GT5SKfmIE4H+3rsuLUjVpi+jCAWejZXkG9uDyiRHh1AF4zIqmMME=
X-Received: by 2002:a50:a1e7:: with SMTP id 94mr23236130edk.165.1592948903362;
 Tue, 23 Jun 2020 14:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200623201745.GG21350@casper.infradead.org>
In-Reply-To: <20200623201745.GG21350@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Jun 2020 14:48:12 -0700
Message-ID: <CAPcyv4jDfm10pGBJHJYA_=C0-+JMor-r7ViAJSJ=u4ZW0FqAow@mail.gmail.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, david <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 23, 2020 at 1:18 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> Hardware actually tells us the blast radius of the error, but we ignore
> it and take out the entire page.  We've had a customer request to know
> exactly how much of the page is damaged so they can avoid reconstructing
> an entire 2MB page if only a single cacheline is damaged.
>
> This is only a strawman that I did in an hour or two; I'd appreciate
> architectural-level feedback.  Should I just convert memory_failure() to
> always take an address & granularity?  Should I create a struct to pass
> around (page, phys, granularity) instead of reconstructing the missing
> pieces in half a dozen functions?  Is this functionality welcome at all,
> or is the risk of upsetting applications which expect at least a page
> of granularity too high?
>
> I can see places where I've specified a plain PAGE_SHIFT insted of
> interrogating a compound page for its size.  I'd probably split this
> patch up into two or three pieces for applying.
>
> I've also blindly taken out the call to unmap_mapping_range().  Again,
> the customer requested that we not do this.  That deserves to be in its
> own patch and properly justified.

I had been thinking that we could not do much with the legacy
memory-failure reporting model and that applications that want a new
model would need to opt-into it. This topic also dovetails with what
Dave and I had been discussing in terms coordinating memory error
handling with the filesystem which may have more information about
multiple mappings of a DAX page (reflink) [1].

[1]: http://lore.kernel.org/r/20200311063942.GE10776@dread.disaster.area
