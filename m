Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA79E729BA3
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjFINcK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFINcJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 09:32:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFDFA3
        for <linux-edac@vger.kernel.org>; Fri,  9 Jun 2023 06:32:08 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 470881EC0373;
        Fri,  9 Jun 2023 15:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686317527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wIEKZsVrVOVQKRBsb55cCt1Rtir0QWl8Mk5XgllJkMQ=;
        b=ZZQ0vl7nNZ+FlaE0OZ71DpkSbwpri/wViIhHH+E9JpElIeNlEaihGsDckfmywSSjUIHsad
        hT/tKk2SuHMJwQpvCtC16Rf+D82NBgq6ypUbc9AecvkkhuQ3Kiywl9PpWhIDMBHmeq2F/M
        /Ts0/I41xBLdAXtkDNmr3x7eN8cpki0=
Date:   Fri, 9 Jun 2023 15:32:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Nitesh Gupta (QUIC)" <quic_nitegupt@quicinc.com>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Rama Krishna (QUIC)" <quic_ramkri@quicinc.com>,
        "Mrinmay Sarkar (QUIC)" <quic_msarkar@quicinc.com>,
        "Shazad Hussain (QUIC)" <quic_shazhuss@quicinc.com>
Subject: Re: Extending EDAC Framework for supporting Non-Memory Issues
Message-ID: <20230609133202.GCZIMp0qhhA6UHDQNJ@fat_crate.local>
References: <c3aafa0390654997ac7876dadf216549@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3aafa0390654997ac7876dadf216549@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

On Fri, Jun 09, 2023 at 12:43:12PM +0000, Nitesh Gupta (QUIC) wrote:
> We intend to stimulate safety errors for PCIe using EDAC framework.

What are "safety errors" and what do you mean by "stimulate"?

> Apart from memory errors safety errors also includes errors like
> transaction timeouts, AER's etc. wrt to PCIe.

So errors reported through AER?

Did you look at Documentation/PCI/pcieaer-howto.rst?

> Modelling these errors on lines of memory error framework would not be
> a good design. Can we extend the current EDAC framework to stimulate
> errors other than memory too??

Why is EDAC a good place for those?

Have a look at Documentation/driver-api/edac.rst first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
