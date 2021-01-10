Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6762F06FA
	for <lists+linux-edac@lfdr.de>; Sun, 10 Jan 2021 13:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAJMBG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Jan 2021 07:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbhAJMBG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Jan 2021 07:01:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5844DC061786
        for <linux-edac@vger.kernel.org>; Sun, 10 Jan 2021 04:00:26 -0800 (PST)
Received: from zn.tnic (p200300ec2f24190001c871219039d0da.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:1900:1c8:7121:9039:d0da])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A2031EC04E0;
        Sun, 10 Jan 2021 13:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610280024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3L3MZOxpCPXrEJqEZvA45JSMQEWJxrO8O6H1WhDTqk=;
        b=VUPmkRXWyJOZfToSZiv2L4JJJbrfEUb/N1coif9Ktznuk0XU9uxSPnw+3N3Fb6yqw3IPtu
        0jHcACWeV60mUTHoyo40QFparj1SGRVYOPTK8+PPhlEE2eb5Ad6A9fUqUgJiaBld4NXhLS
        9iwwyEtMMfE0DwYEI6L7DZjAwT+JXus=
Date:   Sun, 10 Jan 2021 13:00:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     WGH <wgh@torlan.ru>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Subject: Re: Unable to set (or read back) sdram_scrub_rate on amd64_edac
 F17h_M70h (Ryzen 3rd gen)
Message-ID: <20210110120019.GC22211@zn.tnic>
References: <a9cdf7c2-868a-8f67-ac4e-c6bff60552e2@torlan.ru>
 <20210110113308.GB22211@zn.tnic>
 <a7e91287-cb0c-7d40-fa9c-c87d9692f229@torlan.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e91287-cb0c-7d40-fa9c-c87d9692f229@torlan.ru>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jan 10, 2021 at 02:46:52PM +0300, WGH wrote:
> > # setpci -s 00:18.6 0x0x48.l
> % sudo setpci  -s 00:18.6 0x48.l
> b214bac4
> % sudo setpci  -s 00:18.6 0x48.l
> b23225c4
> % sudo setpci  -s 00:18.6 0x48.l
> b2648984
> % sudo setpci  -s 00:18.6 0x48.l
> b27b9dc4
> % sudo setpci  -s 00:18.6 0x48.l
> b293f504
> 
> Whatever that means.

Yah, bit 0 is not set so you're getting scrubrate 0 returned.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
