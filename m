Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7895465B509
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjABQXO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 11:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjABQXN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 11:23:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B824BFA;
        Mon,  2 Jan 2023 08:23:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26A851EC02FE;
        Mon,  2 Jan 2023 17:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672676589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3+jTiV2Tye9DDbjWRWLf44U40+3G9MkAAFupVFRtFU=;
        b=kPI/VzdFJF7lHVjT01/NR8cNv5qYopvcmdtX9PQHSeWK/o2GK9qJGnCzkhQgYy8KOdOEgX
        rrw9aD1JapA0CtwwQYQhGQPxDlrQKGhxghiLn0qNvJz46D7bZGMR3wCC0MS9yOdzz78Ej1
        cbQ9+PUlqLxAZtM+7O+GQJ2cT/O8SDA=
Date:   Mon, 2 Jan 2023 17:23:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     krzysztof.kozlowski@linaro.org, talelshenhar@gmail.com,
        shellykz@amazon.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR
 Controller
Message-ID: <Y7ME6KRv4Hrnt+z9@zn.tnic>
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
 <Y7LfhB5IrLcFzPOi@zn.tnic>
 <4d5eead4-c5f6-f852-9e77-35177887ad22@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d5eead4-c5f6-f852-9e77-35177887ad22@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 02, 2023 at 06:14:04PM +0200, Shenhar, Talel wrote:
> Doesn't it go against the MC EDAC concept...?

You mean the concept of a glorified error reporter? :-)

> Reinventing the wheel is something that usually doesn't end well. (I could
> probably list them but guess that as the EDAC maintainer you can do it
> better than me :)  )

You mean EDAC maintainer because no one else is willing to do it?

See, I don't mind if errors get reported through EDAC but the EDAC "facilities"
are just a reporting mechanism and memory controller layout detection glue.
Yeah, yeah, it can set scrub rate and so on in some drivers but it really is
just that. Oh, and some EDAC drivers provide a simple interrupt handler when the
hw reports errors with a special interrupt.

But, if in your case we get to end up in some weird resources sharing scheme,
then you don't really need the design overhead and you can simply printk the
errors from the other driver.

> I would probably consider the other way around - take the refresh-rate
> driver inside the MC driver as the refresh-rate does not use any "memory"
> framework under drivers/memory.

That is also possible.

The x86 EDAC drivers do get to change settings in the memory controller as a
result of RAS actions because there nothing else "owns" that memory controller.

But I have no clue what your hw does so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
