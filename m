Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899A0275E58
	for <lists+linux-edac@lfdr.de>; Wed, 23 Sep 2020 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIWRKW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWRKW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Sep 2020 13:10:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D0C0613CE;
        Wed, 23 Sep 2020 10:10:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d1300d32f22708559be5e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:d32f:2270:8559:be5e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9AA81EC0354;
        Wed, 23 Sep 2020 19:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600881021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6F9YvtxHG+c2cZaGVC+//+2V2p0AzAkNmUeEjK15LHA=;
        b=XQMQHr5Q8a40hjhYW6qwvs1J2ZBWNLDfOBK11zYoCN1YvZ/7agCRQq+bnb40fVAmhathTw
        EXtmab8xX6/sSpEfZInNfvARusehabBa/PdUpoKXf913rhjRPbgeidfAcT/3Pwu/mRJqzc
        blDSfjklSbvjtjgPzdH7VyVaHb6dVJg=
Date:   Wed, 23 Sep 2020 19:10:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        mchehab@kernel.org, tony.luck@intel.com, aou@eecs.berkeley.edu,
        james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 3/3] EDAC/sifive: Add EDAC support for Memory
 Controller in SiFive SoCs
Message-ID: <20200923171013.GS28545@zn.tnic>
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
 <1599457679-8947-4-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599457679-8947-4-git-send-email-yash.shah@sifive.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 07, 2020 at 11:17:59AM +0530, Yash Shah wrote:
> Add Memory controller EDAC support to the SiFive platform EDAC driver.
> It registers for ECC notifier events from the memory controller.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Reviewed-by is usually enough and stronger than Acked-by. See sections

12) When to use Acked-by:, Cc:, and Co-developed-by:
13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:

in Documentation/process/submitting-patches.rst.

With that addressed:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
