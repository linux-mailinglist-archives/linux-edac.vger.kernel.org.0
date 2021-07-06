Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD773BC61A
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jul 2021 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGFFgr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jul 2021 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhGFFgq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Jul 2021 01:36:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1EFC061574;
        Mon,  5 Jul 2021 22:34:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b980087f7819d44e9d21d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9800:87f7:819d:44e9:d21d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A4F61EC0372;
        Tue,  6 Jul 2021 07:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625549646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ck3bZoJO9buAdOqxqLYXeOV87Hh7y+6NHSEVjMrYQWo=;
        b=qnlqUYsDLrPDKAmHYydgo31PoDxtmFlYa8EK4BYc9wjCkSNC/CWT96J9Cu1/HvnABcs0a9
        pRsgDAkhVF684HSc+mfyqIbQmvjndgj2kHn1ZtcnApZi96oOmJjcXq/TQ+ynLbZLTZMj02
        R+rHJe+K9Ii4QEogZZcp6x22oIYqdu4=
Date:   Tue, 6 Jul 2021 07:33:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
        tony.luck@intel.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Do not load EDAC driver when running as a
 guest
Message-ID: <YOPrRh/3gZ3JETlh@zn.tnic>
References: <20210706050833.9852-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210706050833.9852-1-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 06, 2021 at 07:08:33AM +0200, Jack Wang wrote:
> Similar to commit f0a029fff4a5 ("EDAC/Intel: Do not load EDAC driver when running as a guest")
> 
> There's little to no point in loading an EDAC driver running in a guest.
> 
> Add a check in each of the Intel EDAC drivers for X86_FEATURE_HYPERVISOR
> and simply return -ENODEV in the init routine.

Did you even read this sentence before leaving it in the commit message
or you simply copied the commit message of f0a029fff4a5 blindly?

Also:

https://lore.kernel.org/linux-edac/20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
