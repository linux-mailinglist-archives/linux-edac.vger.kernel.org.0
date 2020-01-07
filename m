Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C645132468
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2020 12:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgAGLDg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 06:03:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34639 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAGLDg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Jan 2020 06:03:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so17472016oig.1;
        Tue, 07 Jan 2020 03:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIJiwe+IJSM2z0EGLFS2PQGz3M9nkcD68T5NhPhR9H8=;
        b=CcKZCfwZJPCPqsKfYcPbHeCIgrb5nyuGzG4g8NYws1HU0a9pHjn9XpiO9j2ihiirp/
         4W0jaMMVy6QhJrLRPaa47jd7wnZ4SXJDD1VPqIW//aernvkAjVWp+BSYpoyq4/pWcE4F
         IkvPow5je2qqfsq6asNMRIePqXyHVf4xGwQXxIq8lq9KoTh/jHmZ59mvNlVGrnhJT1nL
         lTA2kMODrx6Qu7UumTDdGbUG87l2yokDUt0qk6nEPHNI3eQMIen617qYU/eHaQELjAFd
         6UFQ/hiQUToJA8Bj+q6X2cP0qvUoLNM9Pbun1i5ofCAzIkqQ2Cld/ffK7OyiQRhrIbxs
         l6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIJiwe+IJSM2z0EGLFS2PQGz3M9nkcD68T5NhPhR9H8=;
        b=XkG/PTnuCpPF88KA25UBMAFBzMDyXhBmN39ITfFfAdgutgZNvfq2MuD/Fd9rYsV04P
         PnIoP4WNX5MRwHS9hGuusvekMEkSK6tM7EsIo3Bd1lIrUpEEocA3JAp7FtHOuFGv2r4r
         9pZ7XyylsnvOip5dKx/tikv/MLaunML/vYBtoY01HQaoTusYkSegKmQ86+xa9D34+yQ2
         T7ix54Yyt7uQIBfLFifNEt4fDLiS7CFzIwOu8+0QqqhHcUAz9rrjx0uf+xFA59Lzyhjf
         APuF7TEWT8ZHvAwztWD/KZSpBXjnUng6O43mvqxH5Nc+EJx0/0z2voDyntoLw27Ttgnz
         h17w==
X-Gm-Message-State: APjAAAWUaKiHM7fbZ7aLfDMvBt+hwSyI67HI3nIZKveXuWBUJbYyBZ9d
        w3/yB8Q152WtOeKtgEiXXN9ihPWx5mtQCOiG+lBcEw==
X-Google-Smtp-Source: APXvYqwJdREpeWna05No2U9cVuqfKfYHIH1LmsXxw61Z6a3kpnZIlq7281h28otaUoQlZsAkbNf9FwtZsnV+bKGyLg8=
X-Received: by 2002:aca:43c1:: with SMTP id q184mr6326963oia.116.1578395015612;
 Tue, 07 Jan 2020 03:03:35 -0800 (PST)
MIME-Version: 1.0
References: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
 <20200102180130.GG8345@zn.tnic> <CAEYJA6oXTxTmJEji5_Hup2oB+GrgGnmSTiS-nNuzbNzGJ9VESA@mail.gmail.com>
 <20200106130949.GD12238@zn.tnic>
In-Reply-To: <20200106130949.GD12238@zn.tnic>
From:   Bhaskar Upadhaya <bhaskar.upadhaya.linux@gmail.com>
Date:   Tue, 7 Jan 2020 16:33:24 +0530
Message-ID: <CAEYJA6rPiBYnM4rT5WJnvTSrk6GBHeLYxK5OF5oxmeVxVepGGQ@mail.gmail.com>
Subject: Re: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bhaskar Upadhaya <bupadhaya@marvell.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
        gkulkarni@marvell.com, rrichter@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 6, 2020 at 6:39 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 06, 2020 at 04:33:19PM +0530, Bhaskar Upadhaya wrote:
> > Definition of poll interval as per spec (referred ACPI 6.3):
> > "Indicates the poll interval in milliseconds OSPM should use to
> > periodically check the error source for the presence of an error
> > condition."
>
> Please add that...
>
> > We are observing an issue in our ThunderX2 platforms wherein
> > ghes_poll_func is not called within poll interval when timer is
> > configured with TIMER_DEFERRABLE flag(For NO_HZ kernel) and hence we
> > are losing the error records.
>
> ... and that to your commit message then, so that it is crystal clear
> *why* you're making this change.

Thanks Borislav, I will edit the commit message with you comments in
the next patch.
Can I get your Ack in the next patch ?

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
