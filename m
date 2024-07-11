Return-Path: <linux-edac+bounces-1502-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5793A92EB5B
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jul 2024 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C381C22539
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jul 2024 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681F116B388;
	Thu, 11 Jul 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLCxQ0G9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA65477A;
	Thu, 11 Jul 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710688; cv=none; b=kpENNp4glNJqGd+d8Qj4HrwF2I84spq4MMFKdqZKRw+07KcvQ99TXtXg/ckgMTHySR3lzIiDZSF46NHLkJhWHPzDMBwULCUl2F7nmXYyg4xjaM06iv2WJuC4Z+h6+58lGBp6zT/OmoSRioYzd4vM5S4zBH3rGG9ShWVgQzEE7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710688; c=relaxed/simple;
	bh=KJv5O+fnwI7m638Hl0OTuNwGIFqLMp1Wj/vA4Xb7VD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlYV+b+e0ajdK3EaJGFBJCcT12WYw493JWxyMnPBNHK8ioM4m7n/0scq1SCbjob01apjhnuAqAhkeNfcwFSFl6ILY5RlaEOPHUX4wRGa3EhsnlYWDlow98AaAnVXz5mnCjz0RJ0+iMsL9K5wqd3qbQ5EfLaFSt9x4U++3Qb3SHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLCxQ0G9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so716372b3a.1;
        Thu, 11 Jul 2024 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720710686; x=1721315486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjqcD2k7yBNFFIMv18ORQ9h3/ZcEHadXRMMIxuE0fSg=;
        b=lLCxQ0G9VWrGTROKel25L7DVcmk/ERcDEWfQcudhYP349edvXfogQLK0JOwZkVQK/9
         nudxZEBQpo/cEEs64fK4hfC1hvAP3JA6e8eudFsZY0WWJeN7ZYNinB9HKhHxcdTRnXIs
         LzH3M2mBDOvo2LJQYYDqixrwWi0MZ0Q2uNMtFDYp3FlnDdCs4jjNK84RbN51QnSoe5bj
         /lx85OOzS5sqW9BcdsPkyNhpwLl9CqV+O9HW9n6qG2mBw5crYbVk2rUHT47nK9CbLQGm
         X8Wp/3H5WV7iC9kf4+d3hWCN4gDvZGoGLgAZM2d+TJdIBlCuy7nyH8rGLdss24m/pOF7
         sYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710686; x=1721315486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjqcD2k7yBNFFIMv18ORQ9h3/ZcEHadXRMMIxuE0fSg=;
        b=ROSgFLR6CvabTtBnh/w5UMaQKbx63ePbvBn3OZEDxBVXgYiTCJLU1nVkqSDXG/g8sX
         UeEmcjJ7aU69z7Xj/DMk4MIcSwG66exkTAdDNyylKgEUYtOe1/Jc0AFblyMq4MRrFF60
         qAeK9MgJD2Y3hmWiIayzTWh2U+o7aYOfphkz3PM5ONHuETb/DfZuAn5SKIRqHUI1pzRn
         p6xCFMuxkgWRV0CBATWrWKhoDCHQ+Kfj1+Ju4NYWaWlX+DmXfuSLp8K7RnWQTD3c/znT
         +S7aTJkTw3KMbfxIV2b7TR+75oOmd2OGg17r7XjvRBm5X1U061BYl5yG3sJwAvqRYYqt
         jhbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGOE5SyITSiS5vyVDjm3M3wJ4GeX/DQtDrc3997K+T0r6DsR8kg2WKqN2puk+oUT6cXf+XeMbxgCgfSOwCrQVmiVnLqBzc67nhTtuuUHqPpN0MWi+FYOpVXiYXJDiLyeHkCo9CTFBbsA==
X-Gm-Message-State: AOJu0YxeemMbNZD4j9VhIQQHyZ/aMbj1ShdMI0Yx5ENpueobMA3VyUeh
	SPj+CqZR1WIxC3xsa/Vi7oHrKaHEcEs9l3sSiG+iv4vvOXtr0oAx
X-Google-Smtp-Source: AGHT+IGNUjxzlPxKH/kapqaAb/9KWwYDP/oYtQd9KY4Dub2jrY8XFm7Omt/4jHDqfQ1iS5PXVMTTNw==
X-Received: by 2002:a05:6a00:174a:b0:70b:5368:a212 with SMTP id d2e1a72fcca58-70b61dc856amr2900647b3a.15.1720710686001;
        Thu, 11 Jul 2024 08:11:26 -0700 (PDT)
Received: from mobilestation ([217.118.64.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439ee26fsm5778775b3a.209.2024.07.11.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:11:25 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:11:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Michal Simek <michal.simek@amd.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH RESEND v6 02/18] EDAC/synopsys: Fix mci->scrub_cap field
 setting
Message-ID: <wva6x7hrksgvoffpzi5h7q6ucfhdj2fngnezdmnru6gktgmf6q@yfs3lvzrdrhf>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
 <20240627173251.25718-3-fancer.lancer@gmail.com>
 <20240709113522.GEZo0getHKGPD588S1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709113522.GEZo0getHKGPD588S1@fat_crate.local>

On Tue, Jul 09, 2024 at 01:35:22PM +0200, Borislav Petkov wrote:
> On Thu, Jun 27, 2024 at 08:32:09PM +0300, Serge Semin wrote:
> > The mem_ctl_info.scrub_cap field is supposed to be set with the ECC
> > scrub-related flags. Instead the driver erroneously initializes it with
> > the SCRUB_HW_SRC flag ID. It's definitely wrong, but it hasn't caused any
> > problem so far since the structure field isn't used by the EDAC core. Fix
> > it anyway by using the SCRUB_FLAG_HW_SRC macro to initialize the field.
> 
> This hasn't been used at least since it got added by
> 
> commit da9bb1d27b21cb24cbb6a2efb5d3c464d357a01e
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Wed Jan 18 17:44:13 2006 -0800
> 
>     [PATCH] EDAC: core EDAC support code
> 
> AFAICT.
> 
> Please remove ->scrub_cap along with enum scrub_type instead.
> 
> We can always resurrect it if needed.

Agreed. I'll drop all of these from the EDAC core and drivers.

-Serge(y)

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

