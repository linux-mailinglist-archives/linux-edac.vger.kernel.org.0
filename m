Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEA20D80
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfEPQ45 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 12:56:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48272 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfEPQ44 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 12:56:56 -0400
Received: from zn.tnic (p200300EC2F0D4A00F9BFCFFD54267A47.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4a00:f9bf:cffd:5426:7a47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D0301EC0283;
        Thu, 16 May 2019 18:56:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558025815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iXVl9jF+eNO8KIWfnG/VPhBPxmZYEekynfMzOePeuiQ=;
        b=eY4VRSSeqxBO4T0Vi8TtP04r08OdJTQWaC2m+wwU4jMfNXi7G+nU+q/x10j8sPQaiamObI
        u6XrZPlf8AvBBmJsQudYxeuXFtUM11G780IpDFZEj07O0sbNu4e8OWUphBnvTran/+2SH1
        oiYonk3pVMdeRrOC+VweC1ZmabycX2k=
Date:   Thu, 16 May 2019 18:56:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190516165648.GB21857@zn.tnic>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 16, 2019 at 04:14:14PM +0000, Ghannam, Yazen wrote:
> I can put a vendor check on the read. Is that sufficient?

Or we can drop this patch. Remind me again pls why do we need it?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
