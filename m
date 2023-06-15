Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4D731DAC
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFOQVn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 12:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbjFOQVI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 12:21:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715752D4A;
        Thu, 15 Jun 2023 09:20:51 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A93FA1EC085F;
        Thu, 15 Jun 2023 18:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686846049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fNQ7nZqyOoqQPAz6Owt32EonCK4VZRdGyo5Oqwho8p4=;
        b=ESjLBD/55Vtf+frUujS+B4fbiyG/WvESf/twvQExN2GDO3gPDghTmbYvvV2R5hR9jsPglI
        yQEGoO11ZDkVSU+txvjGk6LILwGLSSDY/u/FNCkrX0nJuKdSo6S6/GoTi/P7QWZwL/lRHI
        860x5zNZNJtBH1kFBKisSZQRq3AEM58=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D2AsPzvJnzVd; Thu, 15 Jun 2023 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686846047; bh=fNQ7nZqyOoqQPAz6Owt32EonCK4VZRdGyo5Oqwho8p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7HgKC1u0ccDCXyQjW/kY6pRg8oKgPzhvm/jB7H39ydmehzOVvwWE83bDW5h9F7/J
         IeXSX2w/QoBrpe7K3QyDJfz7tHYfqO9Q683sGebptUv8WSMm1vCo2d8ph/Zk5A0xVt
         FpI4Y/NVLO5eNWcDQ0FX5SrQvfpnIlTA5xbu4QO8nR6IRWgqcJrFXVO+zNWAuQTx8a
         TesCR48e0LvxHIxQ2p9E/+KRCFvSfmVgGEAC6Ze2cJVt4cxfYQ8npTPPTJ8/zEs4oR
         JnLc/q5MkokBduExzPa5lCEzZxK8HLFl4RfY/um0qwF3/9YUx30vNMMlgF5mc2x7DN
         YQa65dyynO/lWzTfydVkCwAPj0PpsuMvcS9V8NdKxhsamE3KEPDOpCh1eJrh8x8liD
         Bg2nZjeBhg9cJGxi7cGx1a7JfUbA8Dk0wNLl0SIq+ZJnUjrK/rhPvMMYKmLlNBtq7Z
         kqY5wjAkenzuFLVmjyF3fyHLVRHIULAST9Jv4DPIeCZuuCg0jsa14bOCviD2DyvXaJ
         5jCVf+IceJItitW+JRMAvvMmgGAW+c9ea2olnFby9dJu79TXFbP1ew/IUuoGOfKqcO
         YCW2gtXcOX0G1gWxJgx3eN97mKMAmEgoTCSviD86PVm7jTWNg7QF0Mg9Gocb8Xdhpd
         opCrA37uo/NkWZ9wCHL7qKEA=
Received: from zn.tnic (p200300ea971DC500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c500:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78C6640E01E2;
        Thu, 15 Jun 2023 16:20:42 +0000 (UTC)
Date:   Thu, 15 Jun 2023 18:20:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Message-ID: <20230615162037.GEZIs6VZG9gVs5QtFT@fat_crate.local>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
 <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 15, 2023 at 11:34:21AM -0400, Yazen Ghannam wrote:
> We can solve the NMI issue if it ever comes up in the future. Unless there's
> an obvious change to avoid this now. Any suggestions?

Yes, solve it right from the get-go. "It cannot happen now" is not good
enough. It should not be even technically possible.

Just report what's logged into BERT - nothing more. Whoever needs the
remaining info, can dump it from the machine.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
