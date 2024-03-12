Return-Path: <linux-edac+bounces-755-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE13878C27
	for <lists+linux-edac@lfdr.de>; Tue, 12 Mar 2024 02:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA4CB20FDD
	for <lists+linux-edac@lfdr.de>; Tue, 12 Mar 2024 01:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492D6FB9;
	Tue, 12 Mar 2024 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eB+KKJnG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F46FB2
	for <linux-edac@vger.kernel.org>; Tue, 12 Mar 2024 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205996; cv=none; b=NVf72GbEBSz1mFcGLDAck3tWY8mw5cEzk1C9Sz7PFjl8isXNCtarZIZ/Maf9yw4iTIOdaZds8aWTlwyx9bIRoRkyaWkiKermMF20LBWcIF8IzjIlDV09c80ICUF6YB3+U2XFGRt2OPRAGJj8MvYQ4PzH75IAdUmPacxi60rBWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205996; c=relaxed/simple;
	bh=OoTfBiXWRGI+caRKGfOwBQ7X4jH3qbOdB8+DW++9Ti4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeE3l8ZdZ325VHxPMaZ6DH4O8NoYuMvdC44lZEMci0BzgHUw1GHpBOBkAtHI8bQVwehczrcpu5QBpa6fA09/KtopIEhNu4suKbKNOXVLGBdPJOqOR2U0QYYIHKmifH8Mpov2uxy4hWPeXFoHlEThixvcqFk9CGgmPkIoEdzMwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eB+KKJnG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5683093ffbbso5377188a12.1
        for <linux-edac@vger.kernel.org>; Mon, 11 Mar 2024 18:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710205992; x=1710810792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ffcfxp86MIw0q9t4PzeGv7I+ngeEtHYjmW7Mt61FKs8=;
        b=eB+KKJnG1fj7ry/MA9wgLbRjat+rzW9/K6OrU0mzHsVFOm3xuvT8hS8xpk2wLLjMaR
         xiuYcqOopBh1nUpF/FjEekEiQ2NPfyvVOsVNu+CthLh/gq9Ef364xQTuN2FLWvBtf0Gi
         F7bJWp2cjCGL5mSa4Qv7JZ0PTsqA58UhUcuI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710205992; x=1710810792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffcfxp86MIw0q9t4PzeGv7I+ngeEtHYjmW7Mt61FKs8=;
        b=oFRvHBndrT3d0VObVzQ6gd32McEIvXkLEpWlAMxa31YEWAVAqGRsfbRwKJSmm6O9Z+
         caoVXE3VEgKnAgA0zsdqnn0KB6c+DmT4b3YvN1LaVDkT4P7OyjaMXWJNQ2/kA8mdT9Tw
         idEFL31j+IQAm50AVK+RDOyoS3z7UmLDjEiAqgZfRQhMmP3x4rCt8xaCRXl+AFZg3kGT
         L96QofzXuf13URtnNCgOPjdFyLCYtRbDQ27QTu3DRGuDwPK/reNs4wZGsi5W6DYRJ06L
         aq7lRALKr7GJgoHfMwDvwxaX/yVi5nPudc7K7Z0Ll8lwkuQqxen/roOKy0XV34hT7ZUH
         pijg==
X-Forwarded-Encrypted: i=1; AJvYcCXIiU0gIeHNnPdWRxYAK4F+0bU9yexKVsJ8TRKXoW6dIZiEk5e8Udnak2gK0tngXFB2HgbQj5RzsGEgHti+DSzh8NlpPPEOvZ/MdQ==
X-Gm-Message-State: AOJu0YzqJ1yymbaigWApMWBLnX6BxBnHM/yjb1YJc3vddDuSqNsqyb62
	eRvnAThrW+dr4djy8Q82R25jTwTef93HmIHIkZu0U4/7IiwADEZIxeZl+JeVu8IB0xPKG8xFSPr
	eSPj7Lg==
X-Google-Smtp-Source: AGHT+IGeDCJOSboo6qElSaIkJNyqC2hkXFCeYiQuhLQiUb5llfy95aDYDf7KY2OY+R1dJRvtohZnCg==
X-Received: by 2002:a05:6402:907:b0:568:3362:cccf with SMTP id g7-20020a056402090700b005683362cccfmr5667756edz.7.1710205992182;
        Mon, 11 Mar 2024 18:13:12 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id m26-20020aa7c2da000000b005682d4f12b4sm3434951edp.45.2024.03.11.18.13.11
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:13:11 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45fd0a0980so321131266b.2
        for <linux-edac@vger.kernel.org>; Mon, 11 Mar 2024 18:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyFO/SWt0T4djFxT5Ihws60g7SPBahjoLUdUvoQgjPqGXDCk4otf3oKcDiO99nuPi9ugbyv5lzd2XOKqjTZco+K+W+uoCyf6mHEQ==
X-Received: by 2002:a17:907:a801:b0:a45:94bf:18e6 with SMTP id
 vo1-20020a170907a80100b00a4594bf18e6mr6438267ejc.73.1710205991317; Mon, 11
 Mar 2024 18:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
In-Reply-To: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 18:12:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
Message-ID: <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for v6.9
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, 
	linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 08:57, Borislav Petkov <bp@alien8.de> wrote:
>
> -       return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
> +       return topology_amd_node_id(err->cpu) % topology_amd_nodes_per_pkg();

Ho humm. Lookie here:

    static inline unsigned int topology_amd_nodes_per_pkg(void)
    { return 0; };

that's the UP case.

Yeah, I'm assuming nobody tests this for UP, but it's clearly wrong to
potentially do that modulus by zero.

So I made the merge also change that UP case of
topology_amd_nodes_per_pkg() to return 1.

Because dammit, not only is a mod-by-zero wrong, a UP system most
definitely has one node per package, not zero.

               Linus

