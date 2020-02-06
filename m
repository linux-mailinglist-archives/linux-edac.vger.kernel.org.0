Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7E1545B0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2020 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFOEm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Feb 2020 09:04:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFOEl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Feb 2020 09:04:41 -0500
Received: from zn.tnic (p200300EC2F0B4B0065ED6F8530E953C0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:65ed:6f85:30e9:53c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 567551EC0CB7;
        Thu,  6 Feb 2020 15:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580997880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nMDT/RnHMsdvnJe7PltUSGUscIEQcDp38vE2QnEZmQ0=;
        b=KSXzHkCTpHFbW7xVEva2B0jCfn1/C6kyzqjRKm5q47vctKOutaODkZn2LwCHnehMTjkV8R
        jlACfFmO3Ks9pZr7Zqd+H3jZDZg4GrJKHmuzcsc5ubiBQsCoe3j0FqABNhefTe/4/DfuWn
        E7CI2vTfG+cRt1QBFL2udRNL4ykTs6o=
Date:   Thu, 6 Feb 2020 15:04:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
Message-ID: <20200206140434.GE9741@zn.tnic>
References: <20200205125831.20430-1-prarit@redhat.com>
 <20200206110811.GC9741@zn.tnic>
 <1f3f5f54-eb31-1e2a-27be-7ed4cb3dc2d3@redhat.com>
 <e4088217-78cc-91f5-fcc9-6152aaf12caf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4088217-78cc-91f5-fcc9-6152aaf12caf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 06, 2020 at 08:05:24AM -0500, Prarit Bhargava wrote:
> Sorry.  I missed this question, but I really don't understand the question.
> Alexander posted a patch in a kernel bugzilla @ Red Hat and I modified the patch
> with some additional changes.  I don't want him to lose credit for the work so
> he's got a proper Signed-off-by tag for this patch.

This is not how this is expressed. Either you write that in free text in
the commit message or you use Co-developed-by. More details in

Documentation/process/submitting-patches.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
