Return-Path: <linux-edac+bounces-5488-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23FC7521F
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0619361B78
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7143635CB70;
	Thu, 20 Nov 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PGzU8Zeh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345532E12B;
	Thu, 20 Nov 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653340; cv=none; b=Twd+wsV7AcaI9M9plYpbnd0jAZzU8WhlEFaBQ8hansN1tqSIjbJSKQR7WmbpCkHC8eloTEXiGJz5zIIwzMR0jGizVF+8si3ywfk8AGLU4I06u+/vERryoeiQwzgCShKP9MSgF79aySzkG++uV6/AJn9BjXMJ2IjNuOUa/aJQzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653340; c=relaxed/simple;
	bh=eZ98W032xGhtzzOcjOKRHJXESIfNISVOPT2tJHZw9LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBOuAfchjr0A009jG3eAV42OoklAO9eYAYEfTKsWQBATM0jMTWQxJ+N8QtMJOtHJfkeIlQSKXxTyrkkLv/1kp+7d/RaH19U4cXk9OlgNgj5VKXDDun2alJiFG3sbmr3vZ+cLs3AxM+UI7lYh3Yk4uc/yzoxWICiwiI85bRn6dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PGzU8Zeh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F9C040E01A5;
	Thu, 20 Nov 2025 15:42:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NrR-lPrdff99; Thu, 20 Nov 2025 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763653324; bh=DHqZabO/ANSQtmpVG/tqnyDvkdQi1bfLKMSaSTgYxik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGzU8Zeh50QvF3/bzc++OjKId8pPa6jnAlkO93jFupml6L4yGy1o3dBAy3aFdgiQQ
	 yxrxy1boh/X9hfemud2jU6RJgrikB6qTd9vbHPkwP/Co8Ocb56d/a2rf1QqTlo0kwJ
	 I+9xfUT2p2PpJq+u3e39OXmxhF6/aEIn7ZKc28jvF/2PBYOmMH5jwAzChjANDl36Jp
	 2si+p5CABesbIDaSzrLrIEdWrjYVbEREcKOB/H7oGJV/TOFECYzUD1rosBWNtdODRQ
	 h4oPs6Rf8zM5jHqLyMpOCTwRjuntLNKlD2CN6Dd6vFYwn8jaLKWwSWBEaF8ESlE3c/
	 julCErinne6+FCfJOMgWjVqnV0xpaZFHBpGQ4zq0vsLEI/KpUwOW2WVnMdeTw3pM+G
	 qsjOmXOjtAkuWQV6L7Tel5wDlOoKwB50QMir49BFsmIu0BjBj4qcK/IMHfuKElLJON
	 Ylzi38QtKR/lwDOfz9G+Zz5JXBTsXt4CVGMXPldzEPZzh1Ismq0u1j1d0lfyTFQhas
	 SAAqvdB02hlUezM7zxpEmh5h5EX5XI4vAgFus2ngvizXZEdrEdNVIVk401IM/Kv2H1
	 6fDT5QUdodc56dXnLf8qAw+bqeNI5puXw12wVe61ngzP1sJg95okuAOFVeq6ZvRx5f
	 j7AmHmPnqiOq6i/bR6kfUt60=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 07B8D40E016D;
	Thu, 20 Nov 2025 15:41:59 +0000 (UTC)
Date: Thu, 20 Nov 2025 16:41:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Yazen.Ghannam@amd.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <20251120154153.GBaR82wW8qjDQA8eoV@fat_crate.local>
References: <20251113111125.823960-1-nik.borisov@suse.com>
 <20251118123352.GJaRxnsHRC6KcbQanQ@fat_crate.local>
 <edfc3212-dc28-43a5-9d9d-c838d253ea88@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edfc3212-dc28-43a5-9d9d-c838d253ea88@suse.com>

On Tue, Nov 18, 2025 at 02:36:08PM +0200, Nikolay Borisov wrote:
> Fair point, but bitwise xor is the lowest possible operation, I guess we
> care about the higher-level effect, which is calculating parity.

... in a function which "Calculate hash for each Bank bit."?

I don't think it matters either way. This is converting the DRAM addressing
scheme into normalized addresses so as long as it is clear what happens
there...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

