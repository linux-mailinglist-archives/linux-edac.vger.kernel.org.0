Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D141A75675F
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jul 2023 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjGQPSI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jul 2023 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjGQPSH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Jul 2023 11:18:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2ABD;
        Mon, 17 Jul 2023 08:18:06 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DFB901EC0CBE;
        Mon, 17 Jul 2023 17:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689607084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GB8ejgjhA70Q76dj14dxnlSp31yxy/iE1gMzhIvNvaE=;
        b=nFJqUpXRyiHFDQheJQqjW7xgOvbsa0A4x8/ZC59usRZIF0NPk+ZoaGvYQjz5EOZtkPYIxc
        3eelbE4a0boewk9HimCkyB7qjaL4vIDxLNJlNXTgmLEK9zmgsjWQNW3OO1uKewGcLOEMrL
        ao7qqxi5d9NijDRkbDEpfbHJExWn+YA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lxppULFFWiiy; Mon, 17 Jul 2023 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689607081; bh=GB8ejgjhA70Q76dj14dxnlSp31yxy/iE1gMzhIvNvaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYFTOMbbkO0gVoEp7V5l+xFsb/UOxvhN1riz4Avre4hkHjf6kURfkXtTstTJlk3xm
         CUL5QIPmhHloT8BIGWNmttxDfkxJgVCMifxcBR5vk72gzcq1RbBRtE+UJF1UqFy5If
         4tHv/+HVFdIyQZkCz6jyGM2m6YIPXVK8H2lzvfBvP2AQ5F9sBTRoMYW30dlJDONMNM
         W6wPUf8fIqSiveT3YfGMwlnUrmrn2WrqG/jRCnO5OY5ecStnAMy9KT3Wj5p84AJler
         lloYUbf3AGk7+KrokpPn1OhhfdDulYaaTDHTcYlv4ORHRP/dhHYloZlulin93eq1uj
         zGssPzAvhE1ZfcyQn4ls17E3m+593o+d+NrkoOjNDG5XWhztzreQmcRHol+M66ZYql
         YG3/XWV3975+fw+7dGHVFYDosRjqFBMbh7Q4ljfu0/8YP4TxKIUsZ/TFomWMMN/0gb
         qrGn4WhB0BBs0qM7qVvX8uCVLZO8F2WkXuJ47NHQFac+xCSHeEDqHsR15sMXsoG8SZ
         uVu3jmHiF5mMi9/pQIQtPbUedp0UlH+5dvRhmLKtAKc0k2hJKQi9qH/3XfLswI5RvQ
         XLOYL0esE7VmY6LlXyj2T/989sSdoDYgygHnuLxawiS0+qCp+cp8xsRqaHQ5EKUjg4
         U1ZhRl8QGNp+2bVB05o+eoug=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BF6340E0185;
        Mon, 17 Jul 2023 15:17:47 +0000 (UTC)
Date:   Mon, 17 Jul 2023 17:17:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: Re: [PATCH v7 2/2] EDAC/versal: Add a Xilinx Versal memory
 controller driver
Message-ID: <20230717151742.GHZLVblh4Wj2XpCXoC@fat_crate.local>
References: <20230614042852.5575-1-shubhrajyoti.datta@amd.com>
 <20230614042852.5575-3-shubhrajyoti.datta@amd.com>
 <20230717081841.GDZLT5Yc/PT77hZ+Xa@fat_crate.local>
 <BY5PR12MB49024D6631D16B3BA68840FD813BA@BY5PR12MB4902.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR12MB49024D6631D16B3BA68840FD813BA@BY5PR12MB4902.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 17, 2023 at 12:31:09PM +0000, Datta, Shubhrajyoti wrote:
> We disable all the interrupts and enable only the correctable and
> non-correctable errors. The disable takes care of the issue that if
> other interrupts are enabled then there is no one to handle the
> interrupts.

What if someone else has enabled an interrupt line for them and you
disable it?

That doesn't make any sense.

> Also the enable interrupts are needed for the driver to work. The
> debug for error injection to test the notification.

The fact that it is not obvious why you're toggling the interrupts there
means you need a big fat comment explaining what you're doing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
