Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45BC73BCE0
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFWQnG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 12:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjFWQnF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 12:43:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB622975;
        Fri, 23 Jun 2023 09:42:44 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A18C1EC04F0;
        Fri, 23 Jun 2023 18:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687538555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xwLJ/+tqlCE0W6lt0hXv8M7a8OEvWqrcIhG8golX4e4=;
        b=f4npGOluADDWo1NIFPspTK4GKkH0WSgYdFWWYZSJh/HaeTRIEJpsODp9++orxsAGGzfXvW
        a3A2Hw4sbxewtdK+voYdga4YW88MrAJd7a52ubjQHce1Cx9kkRxQZXzz9BIMsGmRNmlwdL
        xQBmE3vuu9OYVE8MGws8Z4fxLezliMg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oTw--Hh1b-ou; Fri, 23 Jun 2023 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687538552; bh=xwLJ/+tqlCE0W6lt0hXv8M7a8OEvWqrcIhG8golX4e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cz4/2nZVJniVDGCSRawIV7g2cuvSJfPCjVcFgevVgmqcoYcMy3Y3Z6juKge3ZdxIr
         WZlQAcEpGrSBvbw0eBR72u9VfBApOzxjR1MxzR0rCCwzMWOaMrKEYDkFDvaiz8Eeyd
         s10y6rkZSHCsjwmNpFCW81yOPKR5k4jm5EX1UIz3M8pJejdDubyPTiYr0TKP1237kP
         V/PvoYoE5PSGe2unUcjlLqWbeR2aO9f4xrsTf4ae2dzYb7C/psiDhYgLFFfDnZbZ1o
         PLqfk6fUFjG+iCjkPSELNBcObRbE92rwhDPHAn3dejZlgarRyvv5hiFPoOO8fg4nKc
         JlWPZlnu1fBZVMGkc3GxFJWR77+vbMn9MIHjlxmbvfciSW87W6Wom7nTyv6JUUU+2T
         z+oLwN9oyMF5QI+uHNX5sifFpwYttKooQEH3WQKVFQpbhM5gLNBs6PDp7Osxf58jVt
         JWhMCpfj1rqaPpGOO40HJVoRqo9a6rrnC/RrkKws1SUqRuL7cqCAWJ1sJXjpL9Yyn1
         y35QwI7Q31/4LdCJJzAoBJ6idpYkrbSWfsLy55wwKj6AAMlqyg5UP19DScYZAWCd85
         e9RRGUOUNM5FbI3vrh5I2GFb+8m2Yu2WZUhPO3ONzLeQuxOtT4T5LT2NxZOmZ55oK6
         +s1kBk4EPzPPvs0yHsIrkLw4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DB1A40E0035;
        Fri, 23 Jun 2023 16:42:26 +0000 (UTC)
Date:   Fri, 23 Jun 2023 18:42:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Message-ID: <20230623164221.GCZJXLbSYQebMrVa4y@fat_crate.local>
References: <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
 <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
 <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e6b1af5a-774a-c3ef-223e-4595b7ec532a@amd.com>
 <SJ1PR11MB6083662CBA9A2F40512034D0FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230623160138.GBZJXB4hlFM/ahvROH@fat_crate.local>
 <5f40b5f0-3e19-5cf3-5bd3-eafa4d036119@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f40b5f0-3e19-5cf3-5bd3-eafa4d036119@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 23, 2023 at 12:14:00PM -0400, Yazen Ghannam wrote:
> Or do you mean that we can support mixed microcode systems?

We can and always have. I can chase down hw guys at some point and have
them make a definitive statement about mixed silicon steppings but we
have bigger fish to fry right now.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
