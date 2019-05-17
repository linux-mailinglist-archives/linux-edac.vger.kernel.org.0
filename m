Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A831021EC7
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 21:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfEQTuU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 15:50:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfEQTuU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 15:50:20 -0400
Received: from zn.tnic (p200300EC2F0C500031BA4AEE98C6BAA9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5000:31ba:4aee:98c6:baa9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE1891EC027A;
        Fri, 17 May 2019 21:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558122619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9lSSIdSTOvoJLIE329KgQFST7CEF+yIa+RZC8/2FTy0=;
        b=rTl+bknQrwO15mQdunNHjsaUberhN9hJGUZJtfNLq6rKp8VtEr4ybHW8yFbwOIRvxB515z
        P5GW6c83f4Yc4/XWKESpAbKoOF6d+O5VJf1pVw2830z81jjPh988A+oOH+2ZTGZy8kdo13
        rCDheiDtUPWS8aQLHVUlXARKlz67HdY=
Date:   Fri, 17 May 2019 21:50:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517195013.GJ13482@zn.tnic>
References: <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
 <20190517194405.GA28795@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517194405.GA28795@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 17, 2019 at 12:44:05PM -0700, Luck, Tony wrote:
> Much neater :-)

Finally! :-)

> Acked-by: Tony Luck <tony.luck@intel.com>

Thx.

Yazen, any objections left?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
