Return-Path: <linux-edac+bounces-2955-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6100A22CEC
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AA41884500
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0D1DFDA5;
	Thu, 30 Jan 2025 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCWX2gpv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC71A7046;
	Thu, 30 Jan 2025 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738240081; cv=none; b=q0AkXBUSVZTKrmjoKb6JEBAYETWp63Is94qyzhsD69VA/eDV9aYPQ8hSPFI9oe08mXnZFa55F2whK6lkh7rXSOl2bQFjNL2d/8Jg9h6EK+tiQ6TSKSctdr29vS9UFh0DY0BkKaLvqj9FjkHZuVjJ94pRabIRZl0r9fvd7I2byx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738240081; c=relaxed/simple;
	bh=P30awTIgOo2Uq6vzrX/mHfFsNCzACVlR9l24Wo+/T30=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WXZqP2bF3d9aii5Xc4eMkGCkFGCnCa56eFkVSW5peFLLIwIUigkRlGaS7SRvae2gt6/HAxHQZuCy7hMagZpjJSan0/UZMIXvgmJ/Drp0+lALp3Jb0ncnq/I/DC8+DFOLeSzBTwAAt6kUzvB7DgUyDMTsVJCNKDOYdDcWGn0LDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCWX2gpv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so1113287a91.2;
        Thu, 30 Jan 2025 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738240079; x=1738844879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P30awTIgOo2Uq6vzrX/mHfFsNCzACVlR9l24Wo+/T30=;
        b=UCWX2gpvUaobPitCdb1Y7seVPXD7H3oWHkdx8YBpdUeTldBoJcNoyvkxC+YeguBMOf
         MWqr1GfIyrY1kp79xAuuzp7R4+oUrqjydOPwWCgsqrgkwaFBky7d4C4WHavHv/AlGTo/
         LPN2LeQbCmlINdl59exrdI45dFcRwaHxdSB5z4LjPnMUfSxDJ/3CCDbc7GKeWsPTvw47
         sDhZVT24au+ERchloGQ7Np1JGv3KuLMuCn7U7Y5uxDgxKZJY4D5a6V243ZZTEseBjI9D
         jraNkPRh5sHLVGHGTITpL0wql1FgcujfpVi97I5TTXJO+e7GrvSD+a6x+UA6VvdYiQVU
         jHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738240079; x=1738844879;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P30awTIgOo2Uq6vzrX/mHfFsNCzACVlR9l24Wo+/T30=;
        b=bg38inwjE3Rv6Md4QtjEpCW2E4whCix3SyXrXp/3QBn4IgquiEy1DGh1QvyAqsLbcM
         GvENuDg4YaUS5BnikLTE0pLtsK9YJtV2dwmo2LO8/LoDVcj4TqhZQRm7RgQDK57lnU33
         bwHALNUT5Eku84Ey8Ifk0ihIu961QzV5KGRSooX6RPi76GL/EoGpwotzeHaiAe01aM4B
         qrcj/Za5X7AaTbCRn8lQNn38tivy4YQ9EDRFEiGHEOfSpMwbcZIoJ1IgRvzPiI7Movm/
         TmBRqRbjf5D2VSXvq5mOH6G9X9AvdSIW0xP+sJjNlYD3WimrB+z8ZLliH019X0rNf+82
         j8kg==
X-Forwarded-Encrypted: i=1; AJvYcCW3/NH6sq7Lzqqa2yrRssrovk0kyQjai+en0Ox2j8OiZv99S/Qx7lYpmjv5RozqqtfDdB3+xaNYZcwhahtQ@vger.kernel.org, AJvYcCWz1O5jPKTA9yq12D4ak1/c7lpQBqJ/Rgla4dtUSnTo5aRNZZcSf5CMXkFJLgntyncTFmEiSCxdtU0H@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhqjKG97HES8al4CjjNgTp+3uLo7RuFtNCpBlYkwVFaX+r7Oj
	/6pZbDlPjJjRjRoqVaaYC87HV5bHLh7mt09WLbnUb49Ghst+7cVQzq/HlL5jUwYx3M8zIkg48De
	lKOpmkIkrku6XUAzCFQJ/XW6C9tQ1DhJhYmifBKAM
X-Gm-Gg: ASbGnctXIEbDK+vgMd36HYeiaReHH/f8vcwGj6zvxOdKdEeRUQG2HUW3brFN8EydfIT
	gy4qDbJ7Hod9VgcOKHy0ZVfhW6w5MtCfoQuf86LJEo2YCpLKR61OdvZeUKSIUpORWj8p7sJ6HQw
	==
X-Google-Smtp-Source: AGHT+IFRdApf/Rq5yRkaHkNj89NZ/mM5SEEYhgKNdcZYuusoezHf09GeOj7SYZie9Ajp3bjkJjaTyF3XG54Whwen3M8=
X-Received: by 2002:a17:90b:258c:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-2f83ac00d00mr11902671a91.17.1738240079007; Thu, 30 Jan 2025
 04:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haoyu Li <lihaoyu499@gmail.com>
Date: Thu, 30 Jan 2025 20:27:47 +0800
X-Gm-Features: AWEUYZlgQZeucUXJy48UbS4_ed9USTa4AQqnRbLL6SJuoEkiKdrLJWvLj5HOC3Q
Message-ID: <CAPbMC766gbD52cADhXwK0BC-gN-pmTa0+4Kk4+hyM6LfAWrhJg@mail.gmail.com>
Subject: x86/mce: Potential Information Leak in __mce_read_apei Due to
 Uninitialized Bytes
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, chenyuan0y@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Developers,

I hope this email finds you well.

I would like to bring to your attention a potential issue in the
"__mce_read_apei" function. Specifically, the struct mce m is
initialized via the "apei_read_mce" function before being copied to
user space. However, upon inspecting the call trace (apei_read_mce ->
erst_read_record -> erst_read), we found that not all fields of struct
mce are properly initialized.

This could lead to an information leakage due to uninitialized bytes
being exposed to user space.

Could you please confirm if this is a valid concern? Looking forward
to your insights.

Best regards,
Haoyu Li

