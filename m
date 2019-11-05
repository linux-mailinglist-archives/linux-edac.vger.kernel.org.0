Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F0EFEEF
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 14:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfKENsZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 08:48:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45196 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388860AbfKENsY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 08:48:24 -0500
Received: from zn.tnic (p200300EC2F0EF00014F02C62D0694FB9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f000:14f0:2c62:d069:4fb9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 982891EC0CBB;
        Tue,  5 Nov 2019 14:48:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572961699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6mm00xcBJWVDWWyU6tXbjrS8ETDOe/B1Q8WPOB6PDus=;
        b=XpBpELIOW3nc5f85I3u07i1lkm4oAHq4663nqqHeNJcBrlx58SixkIYyasL6TrhjWFhdLv
        8OAUi0fvOF8IZFGrz7Oq4XEgOZ7V5h+cFIKOQJRW0ZYVnVTVS+TM6ecKqQv6UDegQwMlwO
        AgzFBn6gkkx/MjCS/Y4Goi+P0LgBy/c=
Date:   Tue, 5 Nov 2019 14:48:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191105134812.GA32614@zn.tnic>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
 <20191025133456.GA6483@zn.tnic>
 <BYAPR12MB2630ED1425A3F01727E1C45BF8620@BYAPR12MB2630.namprd12.prod.outlook.com>
 <20191101155412.GA2300@nazgul.tnic>
 <SN6PR12MB2639B236A40754633C8E67F5F87E0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639B236A40754633C8E67F5F87E0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 05, 2019 at 01:38:15PM +0000, Ghannam, Yazen wrote:
> Do you have any other comments on this set?

No, it looks good otherwise.

> Should I send another revision with this change?

Pls do, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
