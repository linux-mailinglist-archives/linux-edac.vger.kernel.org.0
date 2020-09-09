Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569C4263593
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIISHA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Sep 2020 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgIISGz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Sep 2020 14:06:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECCC061573;
        Wed,  9 Sep 2020 11:06:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ae70079c27cf3fd7a9e22.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e700:79c2:7cf3:fd7a:9e22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF9361EC0284;
        Wed,  9 Sep 2020 20:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599674813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oowZjMW+t+gS+Tj+kswLoes6LCsEuL0zY6OVKKw0VoY=;
        b=KC+fv42AE8KvHoZnZa1hmGfSvMMrKganG1by/zmfcpNx7yreZnAXpynKstowe2jagWQpCG
        38bSFrGCcM7Rh9z26yvCkm9KWWzli9cDM+Y0d8jkDK2ZvUIxardRaaKT6kTn8drxq3yETp
        F8O01vLkf9ESzh3yU5X2hCErv0pHZNY=
Date:   Wed, 9 Sep 2020 20:06:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200909180647.GF12237@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903200144.310991-2-Yazen.Ghannam@amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 03, 2020 at 08:01:37PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> AMD systems provide a "NodeId" value that represents a global ID
> indicating to which "Node" a logical CPU belongs. The "Node" is a
> physical structure equivalent to a Die, and it should not be confused
> with logical structures like NUMA node.

So we said in Documentation/x86/topology.rst that:

"The kernel does not care about the concept of physical sockets because
a socket has no relevance to software. It's an electromechanical
component."

Now, you're talking, AFAIU, about physical components. Why do you need
them?

What is then:

  - cpuinfo_x86.phys_proc_id:

    The physical ID of the package. This information is retrieved via CPUID
    and deduced from the APIC IDs of the cores in the package.

supposed to mean?

Why isn't phys_proc_id != node_id?

And so on and so on.

Please get the nomenclature straight first and then we can talk changes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
