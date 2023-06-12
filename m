Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B072BE66
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jun 2023 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFLKKy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jun 2023 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbjFLKJl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Jun 2023 06:09:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5442B6EBF
        for <linux-edac@vger.kernel.org>; Mon, 12 Jun 2023 02:50:19 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFAD81EC008F;
        Mon, 12 Jun 2023 11:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686563417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZSfZoGwkr6tK7l7U0X6X3uxtF9qKMuLhf6o0y4Rsico=;
        b=iP20Zj3aCrLWqPu4XZevSLocjYaRcvmrDrSix0gkgiXtqnnAHgQVQTs7tvnopy9rAT/Q9M
        i5mZnmxzYDdKKkIuWnu+7pDwvCE6hefJoS/QwauZ1UqgMwP0U6lcQDFyciT5UO4SujNF9d
        6vbYBEOVLB/6niHs6M8+Bx885DCS3ek=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686563417; bh=ZSfZoGwkr6tK7l7U0X6X3uxtF9qKMuLhf6o0y4Rsico=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7RrMgLBcKljmIcKs/r8qSR5MPxp+Dj+5az65+9H4KcaGGEbS7GvgkY4GANlBw08E
         ISmA0A+OECq6dMpbspXM3Um8j4S9viy60JkVSwCvxW0xI+BKVWTBdtqnYk1YD7LyY0
         C4Oft77BjPFNLBi1gqPIzSnBx65PbLrguK4o+vYBcvMfOCMjVWhEwRguomkjSphaoO
         8KyKAWPDoKqcOL6b0ORfUpst2X7mnkYR4f/H/idomDksfd6ndmRCQc56lAvFxIReDt
         gDMuyw2CgbHSWct99WhfrmU+L5UaxAH1D378L2YX1eJHkhg/48DIDTuJKnT/Em2ogW
         c3XlEVVQrCELk7wSOg8wpeiBOp0qCpZwjWaWq5UN28WS4o0HqId/cGWOdgXLxKRWKH
         aFXmMWnbJqaAcDVXw9lAjlaikVIriWVcxWMtdagXVYnxgsN6XaxWOu8xQXU08E3zb5
         sRp0Wy0YJlEAB4ZmWD0U8tqOZQMEX6AcfbupA1Mr/sfiNqXxLtKHHSTR3z6/WcFnis
         LqOwPONjRg75jS2oHOszDpKNb9Kapf18FNx3pFzrtE3CMrv1r0jcUFbzl/Zx3n6oKX
         7bmw9DeMBa7LL9M/QoAd+TJ/DRFWMEMz/lvXI4A/Ls9Z6ouK16VCUDF39PbJjJV455
         e/JR4CK0WAdZG/5qhKCsoF+I=
Received: from zn.tnic (p200300Ea971DC508329c23FffeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c508:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E995A40E018C;
        Mon, 12 Jun 2023 09:50:03 +0000 (UTC)
Date:   Mon, 12 Jun 2023 11:49:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nitesh Gupta <nitegupt@qti.qualcomm.com>
Cc:     "Nitesh Gupta (QUIC)" <quic_nitegupt@quicinc.com>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Rama Krishna (QUIC)" <quic_ramkri@quicinc.com>,
        "Mrinmay Sarkar (QUIC)" <quic_msarkar@quicinc.com>,
        "Shazad Hussain (QUIC)" <quic_shazhuss@quicinc.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "Manivannan Sadhasivam (Consultant)" <msadhasi@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: Re: Extending EDAC Framework for supporting Non-Memory Issues
Message-ID: <20230612093510.GDZIbmzj180bkaJfTp@fat_crate.local>
References: <c3aafa0390654997ac7876dadf216549@quicinc.com>
 <20230609133202.GCZIMp0qhhA6UHDQNJ@fat_crate.local>
 <DM6PR02MB4298A388C4B74B3D1519E19CF256A@DM6PR02MB4298.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR02MB4298A388C4B74B3D1519E19CF256A@DM6PR02MB4298.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Jun 10, 2023 at 04:47:01AM +0000, Nitesh Gupta wrote:
> > Apart from memory errors safety errors also includes errors like 
> > transaction timeouts, AER's etc. wrt to PCIe.
> 	>So errors reported through AER?
> 	>Did you look at Documentation/PCI/pcieaer-howto.rst?
> 
> Errors are reported through specific interrupts and then interrupt handler can update the sysfs to intimate to userspace entity to act accordingly.
> 

I don't think you read my mail. Lemme repeat:

"So errors reported through AER?

Did you look at Documentation/PCI/pcieaer-howto.rst?"

Are you saying, this is some homegrown, Qualcomm thing which doesn't
use PCI AER?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
