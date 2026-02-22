Return-Path: <linux-edac+bounces-5733-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMYkAAvfmmkRlwMAu9opvQ
	(envelope-from <linux-edac+bounces-5733-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 11:48:43 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8316EE71
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 11:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BA330120D0
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200A2288E3;
	Sun, 22 Feb 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwGNoB88"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED052253FC
	for <linux-edac@vger.kernel.org>; Sun, 22 Feb 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757309; cv=pass; b=KKcmCHoV4iCU8a8axGodlhZiVnk22ZjIz92RQAPiMAAYqGWyA8H5EYwFW67Qyp4bYEf5eTPssHegUpkvw2ekxFs+nyzA2MdbFEChoCSFLs93P+1TTyd0u8O858ROHaJYJa0pgChKSiM0NDZhjQzbpiQTNOUr6XRqhleFrL1dwlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757309; c=relaxed/simple;
	bh=Eefgy4rL869GmTtHJBeQZKY2WxOxK+X1JIMEDr+qSkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+tXDr/sywl6ttPeImwzWQbhtSmelCQ6zJmwf+bcOaSlPWE+0nkiV7Xx0CxJ9JMwYcIzR/8J9e60dujUTm/vfM7yv6lUbRdju4Ldne+PnTtguaxcf2YQxxaSNyy+OcZV+T+exL8p3/NSUkLUycrPwpwmJB9ZGzHF6DYJNyMAhdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwGNoB88; arc=pass smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so585886166b.1
        for <linux-edac@vger.kernel.org>; Sun, 22 Feb 2026 02:48:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771757307; cv=none;
        d=google.com; s=arc-20240605;
        b=f9naxLIaXv1IR23J2U2X4jiHizVyJa0IHMdLGdMRa9YotMedQVerpjJMFeEo0dNDcJ
         mQ+rAJYXuJqEZNVFvbZZRS0zQAoonJnIsIapqZMsen0lFTtp3mn5S6VzdDxVNV+Hw1X9
         204fSqNeTgwriH8hv1oxYNJDFUSOCVeqdOboUrTb0HsnYIasim2hM6qabQivyK4zbH1w
         /Lp293pgdXzWl4oGttafRqjnqGgXbJkbItKlFSRWAyyM/QroluAZrPhtMq1625oU2Cp1
         ppTSorUPvixOrFH4Dt8qPlrPjGvJT0K3YAhB27Alxc0w6AwRbQ3xBPTAbBf1ol7mws8Q
         HN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Eefgy4rL869GmTtHJBeQZKY2WxOxK+X1JIMEDr+qSkg=;
        fh=15IPGePQqLNXNSmlvW5ZGqK/a8PPFNaZKbZUXdiie6U=;
        b=Ok2jAxrV1bx2S79AMQpSUTgbppPl8EMetEvUJm0ZpVNSfZUcdyxzFxkWN1M2WrTX9W
         fOylT0q6VD7knetL18JnHfzb8hQnr/ar3aARm95TTqTBXciuio8HTfxc77e75QXwiR/6
         yv+DQ4m1Cigh56Eo6IoQrIrhnnlcYunrmlPQumopdUo3TL3QC08PVsRVfbFCaydkmyzm
         cXDmlrZqIOxJe7JMhtd4TYYDTnBT7VLRNcHOiVEBmZJmL/PmedxmAX5mXlV3/gf4Onak
         shsMZZj77K7JHsFyk0uTwi38gA596Tz79WocB5yWVywnDV4I8jdeF1eOkbg76lyvHph7
         APjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771757307; x=1772362107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eefgy4rL869GmTtHJBeQZKY2WxOxK+X1JIMEDr+qSkg=;
        b=kwGNoB884trftrhc24yQd2fRzhp06X/Cl1OCIzsMHXbwtH/nPIISMF2VUl1aI4d0yy
         TziTwugfhWhqsmGj6eekNkhRlZNibA5FzJx/XthPbt5i+Yow7yIDGsuQFve86Rzzqsue
         heSNcsnmiis2EFYtTgM8WblBQiMDcjItjaK713ohOrdiTWh8lKsM5JtvXMnnmw6XH8Z+
         M/pesNt+MB7bEErJY2lMZJCnQeyjhXxO69yCgUY+wcZPWim8cmXPTPF9mouzTkh5KejO
         +n616bUA5YdHl56GnNSYi9cpOpQGk+4t+V5i4hKFXyq8/HiXAcazlbibYBNROiJlZ+7l
         XUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771757307; x=1772362107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eefgy4rL869GmTtHJBeQZKY2WxOxK+X1JIMEDr+qSkg=;
        b=Z+5359vxq70zIeMjJaIuVl4MBCTeo8O1XG96eoLm9WiGztewwef2LfthpUF6G3KZq6
         RHG6jniMQmdwV1O6xB8/ECi7ZbGHVeRPXlLjJcj3LvQPOE4mG9G+zpQVlEqQkcZPXleg
         gcf4kWpXAbeZKUCXlVjjfhmPzKkDhkbYWXBC/dgHN3ITW3z6rkKBUu/6sIl9hxmTtxma
         BvxIN2hMpfZP5qTPQ4ivJQEuMRy4eaa1AWKZzfE/Gjy9LcywSPyaMtC1To8i5uNKLoHB
         letO2A5/drKkSzuESOj4eh+UxQyaJtkgZGBFUuz1UDUT02ab/83+Cjdg8akES/c9mf/L
         VIew==
X-Forwarded-Encrypted: i=1; AJvYcCWit3QtidwXdYcDpDBJneKT9daM2kS1TfEVnGy397WxlLof8f5sPByBmmrq1LPz87W6jphHG8n+sSdl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc5EBry5abRqi8ar9cv7qfVL8arv9vXeCx/T95H0o+8AhEbcDe
	fBIMvsD9OmHvj5ozwfxvvA9PLC96HJgIuAIFKCaKVpPxEdIcioZSfxG5les4lUeHVCaB0FzU4VF
	+PXydvR2Qe5Xprq5cuWXdsv0WnEOWgr0=
X-Gm-Gg: AZuq6aKK8uF0UbC8gMd1KzU9aleUO5+QbEBBQf7yCv8daa8asTzrJO3Klyt3Sn5JPgY
	DFhYsTlawN7AHN6HTa+yD06jepjGq6/OCvrZ0AiKM5WL9B3N5rfnXOKPkXk6/+zoKfbl0/Sh9fC
	7RJvlAteNkfHQxPgp+WTQ4i4I++PLt7g/+AwFEvNH+bnXUWG8b/SGglKmPy9goQ+G14iFDZeFnX
	8Quw90J2WMnTCHstDr2sfXPlRJxcJPC8N6WBPZ/hygA9PNenUiGTQOisp3jytITTk6mAOfy61OM
	q+muVuix9MOzrU1bF8NOsI5c/A20q52VCa1bFhBy
X-Received: by 2002:a17:907:3d4b:b0:b88:587f:f594 with SMTP id
 a640c23a62f3a-b9081a1d9ccmr336451066b.18.1771757306611; Sun, 22 Feb 2026
 02:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221071643.23702-1-ericterminal@gmail.com>
 <997BD3CE-CB86-4A7A-A3AA-E5B15B6FA39C@alien8.de> <CAKNPVZA36XvT7R+QWTOTvAeQNA-sZfnG-h5jV3FnKvKOxqiGtA@mail.gmail.com>
 <FE3C5380-E82B-4EC8-B1C0-16026CEEF8A2@alien8.de>
In-Reply-To: <FE3C5380-E82B-4EC8-B1C0-16026CEEF8A2@alien8.de>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Sun, 22 Feb 2026 18:48:15 +0800
X-Gm-Features: AaiRm505MgLUtqTP6at7_a3Dl6FG-bk-6JmSBJ-OtHymuxm2xfygYpKWOII24CY
Message-ID: <CAKNPVZB1xhRnZ-DaEAWE3qn0EpdS9_q3w2xZKQmS0vhkXtaGvA@mail.gmail.com>
Subject: Re: [PATCH] EDAC/versalnet: Fix resource leaks and NULL derefs in init_versalnet()
To: Borislav Petkov <bp@alien8.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-kernel@vger.kernel.org, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5733-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 82D8316EE71
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 3:22 PM Borislav Petkov <bp@alien8.de> wrote:
> First of all,
>
> do not top-post when replying to community mails.

My apologies for the formatting errors and for accidentally taking
this discussion off-list. I'm a newcomer and still learning the
etiquette.

> Then, when you reply, hit reply-to-all in your mail client. The
> discussions we have are not private ones but are documented on public
> mailing lists for a reason.

Understood. I have added the mailing lists back to CC and will ensure
all future technical discussions remain public.

> Then, about this particular question:
>
> "...then you just add a line saying:
>
> Signed-off-by: Random J Developer <random@developer.example.org>
>
> using your real name (sorry, no pseudonyms or anonymous contributions.)"

I see. Thank you for the clarification. My real name is Yufan Chen.

I have thoroughly read the submission documentation and have just
resubmitted the patch as V2 with the corrected
Signed-off-by: Yufan Chen <ericterminal@gmail.com>.

Best regards,
Yufan Chen

