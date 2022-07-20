Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75357B5E2
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiGTLvf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTLve (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 07:51:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC5357206;
        Wed, 20 Jul 2022 04:51:31 -0700 (PDT)
Received: from zn.tnic (p200300ea97297623329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7623:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 426401EC04D6;
        Wed, 20 Jul 2022 13:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658317886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G5tDrsT2sWzYk3Hji+KyAgj0z5FZBjNVpsVxlTCfyRU=;
        b=o8Ka6MQersjBulW1eATTQ3ok9Y+q3VT63ez33EzV6yUOr4O4rAcqxO3cZOCXqMPFNzE4pg
        +Ne2jrxAoKgxFcPKjWLNiZ6c+hxxz0aCvTF0kuCddVJTLfexDj0VzZ4T8vXaTCu8iYXd/t
        arsTveHiAJ212DDda3ZyxOGleUbwJ7Y=
Date:   Wed, 20 Jul 2022 13:51:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     rrichter@marvell.com, mchehab@kernel.org, elliott@hpe.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <YtfsOcWbWREu1NnK@zn.tnic>
References: <20220719220124.760359-1-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220719220124.760359-1-toshi.kani@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 19, 2022 at 04:01:24PM -0600, Toshi Kani wrote:
> The following buffer overflow BUG was observed on an HPE system.
> ghes_edac_register() called strlen() on an uninitialized label,
> which had non-zero values from krealloc_array().
> Change dimm_setup_label() to always initialize the label.

Do we also know why dmi_memdev_name() doesn't give bank and/or device?

SMBIOS handle wrong?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
